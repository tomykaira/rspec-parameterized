require "rspec/parameterized/version"
require 'ruby2ruby'
require 'sourcify'

module RSpec
  module Parameterized
    module ExampleGroupMethods

      # Set parameters to be bound in specs under this example group.
      #
      # ## Example
      #
      #     where(:a, :b, :answer) do
      #       [
      #         [1 , 2 , 3],
      #         [5 , 8 , 13],
      #         [0 , 0 , 0]
      #       ]
      #     end
      #
      def where(*args, &b)
        set_parameters(args, b.call)
      end

      # Set parameters to be bound in specs under this example group.
      # You can separate fields with | like a cucumber table.
      #
      # ## Example
      #
      #     where(:a, :b, :answer) do
      #       1 | 2 | 3
      #       5 | 8 | 13
      #       0 | 0 | 0
      #     end
      #
      def where_table(*args, &b)
        set_parameters(args, separate_table_like_block(b))
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
        if @arg_names.nil? || @param_sets.nil?
          @parameterized_pending_cases ||= []
          @parameterized_pending_cases << [args, b]
        else
          define_cases(@arg_names, @param_sets, *args, &b)
        end
      end

      private
      def set_parameters(arg_names, param_sets)
        @arg_names = arg_names
        @param_sets = param_sets
        if @parameterized_pending_cases
          @parameterized_pending_cases.each { |e|
            define_cases(arg_names, param_sets, *e[0], &e[1])
          }
        end
      end

      def separate_table_like_block(b)
        sexp = b.to_sexp(:strip_enclosure => true)

        lines = sexp.find_nodes(:call)
        lines.map do |l|
          rev_insts = []
          while l.sexp_type == :call and l[2] == :|
            rev_insts << eval_sexp(l[3][1])
            l = l[1]
          end
          rev_insts << eval_sexp(l)
          rev_insts.reverse
        end
      end

      def eval_sexp(sexp)
        self.instance_eval(ruby2ruby.process(sexp))
      end

      def ruby2ruby
        @ruby2ruby ||= Ruby2Ruby.new
      end

      def define_cases(arg_names, param_sets, *args, &block)
        param_sets.each do |params|
          describe(params.inspect, *args) do
            [arg_names, params].transpose.each do |n|
              let(n[0]) { n[1] }
            end

            module_eval(&block)
          end
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
