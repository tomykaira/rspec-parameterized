require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSpec::Parameterized do
  describe "Sample" do
    describe "plus" do
      where(:a, :b, :c) do
        [
          [1 , 2 , 3],
          [5 , 8 , 13],
          [0 , 0 , 0]
        ]
      end

      ittt "should do additions" do
        p a, b, answer
        (a + b).should == answer
      end
    end
  end
end
