module RSpec
  module Parameterized
    module ExampleHelperMethods
      def recursive_apply(val)
        return val.apply(self) if HelperMethods.applicable?(val)

        if val.is_a?(Array)
          return val.map { |child_val| recursive_apply(child_val) }
        end

        if val.is_a?(Hash)
          return val.map { |key, value| [recursive_apply(key), recursive_apply(value)] }.to_h
        end

        val
      end
    end
  end
end
