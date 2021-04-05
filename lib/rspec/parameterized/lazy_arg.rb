module RSpec
  module Parameterized
    class LazyArg < Arg
      def initialize(&block)
        @block = block
      end

      def apply(obj)
        obj.instance_eval(&@block)
      end

      def inspect
        "#{@block.to_raw_source}"
      rescue Parser::SyntaxError
        super.inspect
      end
    end
  end
end
