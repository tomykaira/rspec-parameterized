require "rspec/parameterized/version"

module RSpec
  module Parameterized
    module ExampleGroupMethods
      def where(&b)
        puts "here"
      end
    end
  end

  module Core
    class ExampleGroup
      extend ::RSpec::Parameterized::ExampleGroupMethods
    end
  end
end
