module RSpec
  module Parameterized
    class Table
      attr_reader :last_row

      def initialize
        @rows = []
        @last_row = nil
      end

      def add_row(row)
        unless @rows.find {|r| r.object_id == row.object_id}
          @rows << row
          @last_row = row
        end
        self
      end

      def add_param_to_last_row(param)
        last_row.add_param(param)
        self
      end
      alias :| :add_param_to_last_row

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
        end

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
