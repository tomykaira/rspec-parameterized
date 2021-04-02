require 'rspec/parameterized/ref_arg'
require 'rspec/parameterized/lazy_arg'
module RSpec
  module Parameterized
    module HelperMethods
      def ref(symbol)
        RefArg.new(symbol)
      end

      def lazy(&block)
        LazyArg.new(&block)
      end

      def self.applicable?(arg)
        arg.is_a? Arg
      end
    end
  end
end

