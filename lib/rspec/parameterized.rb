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
        @arg_names = args
        @param_sets = b.call
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
        @arg_names = args
        @param_sets = separate_table_like_block(b)
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
      def with_them(*args, &block)
        arg_names = @arg_names
        @param_sets.each do |params|
          describe(params.inspect, *args) do
            [arg_names, params].transpose.each do |n|
              let(n[0]) { n[1] }
            end

            module_eval(&block)
          end
        end
      end

      private
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
    end
  end

  module Core
    class ExampleGroup
      extend ::RSpec::Parameterized::ExampleGroupMethods
    end
  end
end
