module RSpec
  module Parameterized
    class Table
      def initialize(row)
        @rows = [row]
      end

      def add_row(row)
        @rows << row
        self
      end
      alias :> :add_row

      def to_a
        @rows.map(&:to_a)
      end
      alias :to_params :to_a

      class Row
        def initialize(param)
          @params = [param]
        end

        def add_param(param)
          @params << param
          self
        end
        alias :| :add_param

        def next_row(other)
          Table.new(self) > other
        end
        alias :> :next_row

        def to_a
          @params
        end

        def to_params
          [@params]
        end
      end
    end
  end
end
