require "rspec/parameterized/version"

module RSpec
  module Parameterized
    module ExampleMethods
      def ittt(desc=nil, *args, &block)
        p desc
        param_sets.each do |params|
          context params.inspect do
            [arg_names, params].transpose.each do |n, p|
              let(n) { p }
            end
            it(desc, *args, &block)
          end
        end
      end
    end

    module ExampleGroupMethods

      attr_reader :arg_names, :param_sets

      def where(*args, &b)
        @arg_names = args
        @param_sets = b.call
      end
    end
  end

  module Core
    class ExampleGroup
      extend ::RSpec::Parameterized::ExampleGroupMethods
      include ::RSpec::Parameterized::ExampleMethods
    end
  end
end
