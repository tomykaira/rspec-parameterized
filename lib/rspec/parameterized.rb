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
        attr_reader :arg_names, :block

        def initialize(arg_names, &block)
          @arg_names, @block = arg_names, block
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

          set_parameters(params.keys) {
            first.product(*rest)
          }
        else
          set_parameters(args, &b)
        end
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
      def set_parameters(arg_names, &b)
        @parameter = Parameter.new(arg_names, &b)

        if @parameterized_pending_cases
          @parameterized_pending_cases.each { |e|
            define_cases(@parameter, *e[0], &e[1])
          }
        end
      end

      def define_cases(parameter, *args, &block)
        instance = new  # for evaluate let methods.
        if defined?(self.superclass::LetDefinitions)
          instance.extend self.superclass::LetDefinitions
        end

        extracted = instance.instance_eval(&parameter.block)
        param_sets = extracted.is_a?(Array) ? extracted : extracted.to_params

        # for only one parameters
        param_sets = param_sets.map { |x| Array[x] } if !param_sets[0].is_a?(Array)

        param_sets.each do |params|
          pairs = [parameter.arg_names, params].transpose
          pretty_params = pairs.map {|t| "#{t[0]}: #{params_inspect(t[1])}"}.join(", ")
          describe(pretty_params, *args) do
            pairs.each do |n|
              let(n[0]) { n[1] }
            end

            module_eval(&block)
          end
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
