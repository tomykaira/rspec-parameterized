require 'rspec/parameterized/table'

module RSpec
  module Parameterized
    module TableSyntax
      refine Object do
        def |(other)
          Table::Row.new(self) | other
        end
      end

      refine Fixnum do
        def |(other)
          Table::Row.new(self) | other
        end
      end

      refine Bignum do
        def |(other)
          Table::Row.new(self) | other
        end
      end

      refine Array do
        def |(other)
          Table::Row.new(self) | other
        end
      end
    end
  end
end
