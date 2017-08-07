require 'rspec/parameterized/table'
require 'binding_ninja'

module RSpec
  module Parameterized
    module TableSyntaxImplement
      extend BindingNinja

      def |(where_binding, other)
        caller_instance = where_binding.receiver # get caller instance (ExampleGroup)

        if caller_instance.instance_variable_defined?(:@__parameter_table)
          table = caller_instance.instance_variable_get(:@__parameter_table)
        else
          table = RSpec::Parameterized::Table.new
          caller_instance.instance_variable_set(:@__parameter_table, table)
        end

        row = Table::Row.new(self)
        table.add_row(row)
        row.add_param(other)
        table
      end
      auto_inject_binding :|
    end

    module TableSyntax
      refine Object do
        include TableSyntaxImplement
      end

      if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create("2.4.0")
        refine Integer do
          include TableSyntaxImplement
        end
      else
        refine Fixnum do
          include TableSyntaxImplement
        end

        refine Bignum do
          include TableSyntaxImplement
        end
      end

      refine Array do
        include TableSyntaxImplement
      end

      refine NilClass do
        include TableSyntaxImplement
      end

      refine TrueClass do
        include TableSyntaxImplement
      end

      refine FalseClass do
        include TableSyntaxImplement
      end
    end
  end
end
