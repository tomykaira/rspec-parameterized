module RSpec
  module Parameterized
    class LazyArg < Arg
      def initialize(&block)
        @block = block
      end

      def apply(obj)
        obj.instance_eval(&@block)
      end
    end
  end
end
