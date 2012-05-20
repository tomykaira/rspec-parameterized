require "rspec/parameterized/version"

module RSpec
  module Parameterized
    module ExampleGroupMethods
      def where(*args, &b)
        @arg_names = args
        @param_sets = b.call
      end

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
