require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSpec::Parameterized do
  describe "Sample" do
    describe "plus" do
      it "should do additions", :with_sample => true do |a, b, answer|
        (a + b).should == answer
      end

      where do
        1 | 2 | 3
        5 | 8 | 13
        0 | 0 | 0
      end
    end
  end
end
