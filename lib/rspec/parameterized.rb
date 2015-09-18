require "rspec/parameterized/version"
require 'parser'
require 'unparser'
require 'proc_to_ast'

module RSpec
  module Parameterized
    autoload :TableSyntax, 'rspec/parameterized/table_syntax'

    module ExampleGroupMethods
      # capsulize parameter attributes
      class Parameter
        attr_reader :arg_names, :table_format, :block

        def initialize(arg_names, table_format, &block)
          @arg_names, @table_format, @block = arg_names, table_format, block
        end
      end

      # Set parameters to be bound in specs under this example group.
      #
      # ## Example1
      #
      #     where(:a, :b, :answer) do
      #       [
      #         [1 , 2 , 3],
      #         [5 , 8 , 13],
      #         [0 , 0 , 0]
      #       ]
      #     end
      #
      # ## Example2
      #     using RSpec::Parameterized::TableSyntax
      #     where(:a, :b, :answer) do
      #       1 | 2 | 3 >
      #       5 | 8 | 13 >
      #       0 | 0 | 0
      #     end
      #
      def where(*args, &b)

        if args.size == 1 && args[0].instance_of?(Hash)
          params = args[0]
          first, *rest = params.values

          set_parameters(params.keys, false) {
            first.product(*rest)
          }
        else
          set_parameters(args, false, &b)
        end
      end

      # Set parameters to be bound in specs under this example group.
      # You can separate fields with | like a cucumber table.
      #
      # ## Example
      #
      #     where_table(:a, :b, :answer) do
      #       1 | 2 | 3
      #       5 | 8 | 13
      #       0 | 0 | 0
      #     end
      #
      def where_table(*args, &b)
        warn "deprecated: `where_table` method is deprecated. Please use `using RSpec::Parameterized::TableSyntax`"
        warn caller.first
        set_parameters(args, true, &b)
      end

      # Use parameters to execute the block.
      # The given block is converted into +describe+s for each parameter set.
      #
      # ## Example
      #     with_them do
      #       it "should do additions" do
      #         (a + b).should == answer
      #       end
      #     end
      #
      def with_them(*args, &b)
        if @parameter.nil?
          @parameterized_pending_cases ||= []
          @parameterized_pending_cases << [args, b]
        else
          define_cases(@parameter, *args, &b)
        end
      end

      private
      def set_parameters(arg_names, table_format, &b)
        @parameter = Parameter.new(arg_names, table_format, &b)

        if @parameterized_pending_cases
          @parameterized_pending_cases.each { |e|
            define_cases(@parameter, *e[0], &e[1])
          }
        end
      end

      def separate_table_like_block(b)
        ast = b.to_ast
        inner_ast = ast.children[2]
        if inner_ast.type == :send
          lines = [inner_ast]
        else
          lines = inner_ast.children
        end

        lines.map do |node|
          if node.type == :send
            buf = []
            extract_value(node, buf)
            buf.reverse
          end
        end
      end

      def extract_value(node, buf)
        receiver, method, arg = node.children

        if method == :|
          buf << eval_source_fragment(Unparser.unparse(arg))
        end

        if receiver.is_a?(AST::Node) && receiver.type == :send && receiver.children[1] == :|
          extract_value(receiver, buf)
        else
          buf << eval_source_fragment(Unparser.unparse(receiver))
        end
      end

      def eval_source_fragment(source_fragment)
        instance = new  # for evaluate let methods.
        if defined?(self.superclass::LetDefinitions)
          instance.extend self.superclass::LetDefinitions
        end
        instance.instance_eval(source_fragment)
      end

      def define_cases(parameter, *args, &block)
        instance = new  # for evaluate let methods.
        if defined?(self.superclass::LetDefinitions)
          instance.extend self.superclass::LetDefinitions
        end

        if parameter.table_format
          param_sets = separate_table_like_block(parameter.block)
        else
          extracted = instance.instance_eval(&parameter.block)
          if extracted.is_a?(Array)
            param_sets = extracted
          else
            if extracted.respond_to?(:to_params)
              param_sets = extracted.to_params
            else
              param_sets = extracted
            end
          end
        end

        keys = []
        if param_sets.is_a?(Hash)
          define_case_node(parameter, args, block, param_sets, keys)
        else
          # for only one parameters
          param_sets = param_sets.map { |x| Array[x] } if !param_sets[0].is_a?(Array)

          param_sets.each do |params|
            define_assert(parameter, args, block, params, keys)
          end
        end
      end

      def define_case_node(parameter, args, block, param_sets, keys)
        if param_sets.is_a?(Hash)
          param_sets.map do |key, params|
            describe key.to_s do
              define_case_node(parameter, args, block, params, keys+[key])
            end
          end
        else
          define_assert(parameter, args, block, param_sets, keys)
        end
      end

      def define_assert(parameter, args, block, params, keys)
        pairs = [parameter.arg_names, keys + params].transpose
        pretty_params = pairs.map {|t| "#{t[0]}: #{params_inspect(t[1])}"}.join(", ")
        describe(pretty_params, *args) do
          pairs.each do |n|
            let(n[0]) { n[1] }
          end

          module_eval(&block)
        end
      end

      def params_inspect(obj)
        begin
          obj.is_a?(Proc) ? obj.to_raw_source : obj.inspect
        rescue Parser::SyntaxError
          return obj.inspect
        end
      end
    end
  end

  module Core
    class ExampleGroup
      extend ::RSpec::Parameterized::ExampleGroupMethods
    end
  end
end
