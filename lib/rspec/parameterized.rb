require "rspec/parameterized/version"

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
    end
  end

  module Core
    class ExampleGroup
      extend ::RSpec::Parameterized::ExampleGroupMethods
    end
  end
end
