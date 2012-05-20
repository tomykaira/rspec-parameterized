require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# RSpec::Parameterized
#   Sample
#     plus
#       [1, 2, 3]
#         should do additions
#       [5, 8, 13]
#         should do additions
#       [0, 0, 0]
#         should do additions

describe RSpec::Parameterized do
  describe "Sample" do
    describe "plus" do
      where(:a, :b, :answer) do
        [
          [1 , 2 , 3],
          [5 , 8 , 13],
          [0 , 0 , 0]
        ]
      end

      with_them do
        it "should do additions" do
          (a + b).should == answer
        end
      end
    end
  end
end
