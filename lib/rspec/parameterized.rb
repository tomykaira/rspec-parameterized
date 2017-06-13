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
          naming_func = args.first.delete(:case_names)
          params = args[0]
          first, *rest = params.values
          arg_names = params.keys
          arg_values = first.product(*rest)

          if naming_func && naming_func.respond_to?(:call)
            arg_names << :case_name
            arg_values.map! { |row| row << naming_func.call(*row) }
          end

          set_parameters(arg_names) {
            arg_values
          }
        elsif args.size == 0
          set_verbose_parameters(&b)
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
        opts = args.last.is_a?(Hash) ? args.pop : {}
        opts[:caller] = caller unless opts[:caller]
        args.push(opts)

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

        param_sets.each do |param_set|
          pairs = [parameter.arg_names, param_set].transpose.to_h
          pretty_params = pairs.has_key?(:case_name) ? pairs[:case_name] : pairs.map {|name, val| "#{name}: #{params_inspect(val)}"}.join(", ")
          describe(pretty_params, *args) do
            pairs.each do |name, val|
              let(name) { val }
            end

            singleton_class.module_eval do
              if respond_to?(:params)
                warn "ExampleGroup.params method is overrided."
              end

              define_method(:params) do
                pairs
              end

              if respond_to?(:all_params)
                warn "ExampleGroup.all_params method is overrided."
              end

              define_method(:all_params) do
                param_sets
              end
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

      def set_verbose_parameters(&block)
        arguments_hash = yield
        arg_names = arguments_hash.values.reduce(Set.new) { |memo, pairs| memo | pairs.keys }.to_a
        arg_values = []
        arguments_hash.each do |name, values_hash|
          row = [name]
          arg_names.each do |argument_name|
              row << values_hash[argument_name]
          end
          arg_values << row
        end
        arg_names.unshift(:case_name)
        set_parameters(arg_names) {
          arg_values
        }
      end
    end
  end

  module Core
    class ExampleGroup
      extend ::RSpec::Parameterized::ExampleGroupMethods
    end
  end
end
