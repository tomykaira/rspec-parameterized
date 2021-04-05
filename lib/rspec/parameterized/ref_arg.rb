require 'rspec/parameterized/arg'
module RSpec
  module Parameterized
    class RefArg < Arg
      def initialize(symbol)
        @symbol = symbol
      end

      def apply(obj)
        obj.send(@symbol)
      end

      def inspect
        "#{@symbol}"
      end
    end
  end
end

