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
  describe "where and with_them" do
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

    with_them :pending do
      it "should do additions" do
        (a + b).should == answer
      end
    end
  end

  describe "lambda parameter" do
    where(:a, :b, :answer) do
      [
        [1 , 2 , -> {should == 3}],
        [5 , 8 , -> {should == 13}],
        [0 , 0 , -> {should == 0}]
      ]
    end

    with_them do
      subject {a + b}
      it "should do additions" do
        self.instance_exec(&answer)
      end
    end
  end


  describe "table separated with pipe" do
    where_table(:a, :b, :answer) do
      1         | 2         | 3
      "hello "  | "world"   | "hello world"
      [1, 2, 3] | [4, 5, 6] | [1, 2, 3, 4, 5, 6]
    end

    with_them do
      it "a plus b is answer" do
        (a + b).should == answer
      end
    end
  end

  context "when the where block is after with_them" do
    with_them do
      it "should do additions" do
        (a + b).should == answer
      end
    end

    with_them do
      subject { a }
      it { should be_is_a Numeric }
    end

    where(:a, :b, :answer) do
      [
        [1 , 2 , 3],
        [5 , 8 , 13],
        [0 , 0 , 0]
      ]
    end
  end

  context "when the where block is between with_thems" do
    with_them do
      it "should do additions" do
        (a + b).should == answer
      end
    end

    where(:a, :b, :answer) do
      [
        [1 , 2 , 3],
        [5 , 8 , 13],
        [0 , 0 , 0]
      ]
    end

    with_them do
      subject { a }
      it { should be_is_a Numeric }
    end
  end
end
