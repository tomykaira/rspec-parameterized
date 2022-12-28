require 'rspec/parameterized/table'
require 'binding_of_caller'

module RSpec
  module Parameterized
    module TableSyntaxImplement
      def |(other)
        where_binding = binding.of_caller(1)          # get where block binding
        caller_instance = eval("self", where_binding) # get caller instance (ExampleGroup)

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
    end

    module TableSyntax
      if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create("3.2.0.rc1")
        refine Object do
          import_methods TableSyntaxImplement
        end

        refine Integer do
          import_methods TableSyntaxImplement
        end

        refine Array do
          import_methods TableSyntaxImplement
        end

        refine NilClass do
          import_methods TableSyntaxImplement
        end

        refine TrueClass do
          import_methods TableSyntaxImplement
        end

        refine FalseClass do
          import_methods TableSyntaxImplement
        end
      else
        refine Object do
          include TableSyntaxImplement
        end

        refine Integer do
          include TableSyntaxImplement
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
end
