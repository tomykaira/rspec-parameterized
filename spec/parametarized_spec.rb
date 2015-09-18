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
        expect(a + b).to eq answer
      end
    end

    with_them pending: "PENDING" do
      it "should do additions" do
        expect(a + b).to == answer
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

  describe "Hash arguments" do
    where(a: [1, 3], b: [5, 7, 9], c: [2, 4])

    with_them do
      it "sums is even" do
        expect(a + b + c).to be_even
      end
    end
  end

  describe "hash parameter" do
    where(:a, :b, :answer) do
      {
        1 => [2 , 3],
        2 => [8 , 10],
      }
    end

    with_them do
      it "should do additions" do
        expect(a + b).to eq answer
      end
    end

    with_them pending: "PENDING" do
      it "should do additions" do
        expect(a + b).to == answer
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
        expect(a + b).to eq answer
      end
    end
  end

  if RUBY_VERSION >= "2.1"
    describe "table separated with pipe (using TableSyntax)" do
      using RSpec::Parameterized::TableSyntax

      where(:a, :b, :answer) do
        1         | 2         | 3
        "hello "  | "world"   | "hello world"
        [1, 2, 3] | [4, 5, 6] | [1, 2, 3, 4, 5, 6]
      end

      with_them do
        it "a plus b is answer" do
          expect(a + b).to eq answer
        end
      end
    end

    describe "table separated with pipe and lambda parameter (using TableSyntax)" do
      using RSpec::Parameterized::TableSyntax

      where(:a, :b, :matcher) do
        1         | 2         | -> { eq(3) }
        "hello "  | "world"   | -> { eq("hello world") }
        [1, 2, 3] | [4, 5, 6] | -> { be_a(Array) }
      end

      with_them do
        it "a plus b is answer" do
          expect(a + b).to instance_exec(&matcher)
        end
      end
    end
  end

  context "when the where block is after with_them" do
    with_them do
      it "should do additions" do
        expect(a + b).to eq answer
      end
    end

    with_them do
      subject { a }
      it { should be_a Numeric }
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
        expect(a + b).to eq answer
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
      it { should be_a Numeric }
    end
  end

  context "when the where has only one parameter to be set" do
    where(:x) do
      [1, 2, 3]
    end

    with_them do
      it 'can take an array of elements' do
        expect(x).to eq x
      end
    end
  end

  context "when the table has only a row" do
    where_table(:a, :b, :answer) do
      1         | 2         | 3
    end

    with_them do
      it "a plus b is answer" do
        expect(a + b).to eq answer
      end
    end
  end

  if RUBY_VERSION >= "2.1"
    context "when the table has only a row (using TableSyntax)" do
      using RSpec::Parameterized::TableSyntax

      where(:a, :b, :answer) do
        1         | 2         | 3
      end

      with_them do
        it "a plus b is answer" do
          expect(a + b).to eq answer
        end
      end
    end
    context "when 1st column is nil or true or false" do
      using RSpec::Parameterized::TableSyntax
      where(:a, :result) do
        nil   | nil
        false | false
        true  | true
      end

      with_them do
        it "a is result" do
          expect(a).to be result
        end
      end
    end
  end

  context "when the where has let variables, defined by parent example group" do
    describe "parent (define let)" do
      let(:five) { 5 }
      let(:eight) { 8 }

      describe "child 1" do
        where(:a, :b, :answer) do
          [
            [1 , 2 , 3],
            [five , eight , 13],
          ]
        end

        with_them do
          it "a plus b is answer" do
            expect(a + b).to eq answer
          end
        end
      end

      describe "child 2 (where_table)" do
        where_table(:a, :b, :answer) do
          1         | 2         | 3
          five      | eight     | 13
        end

        with_them do
          it "a plus b is answer" do
            expect(a + b).to eq answer
          end
        end
      end

      if RUBY_VERSION >= "2.1"
        describe "child 3 (Using TableSyntax)" do
          using RSpec::Parameterized::TableSyntax

          where(:a, :b, :answer) do
            1         | 2         | 3
            five      | eight     | 13
          end

          with_them do
            it "a plus b is answer" do
              expect(a + b).to eq answer
            end
          end
        end
      end

      let(:eq_matcher) { eq(13) }
      describe "child 3 (use matcher)" do
        where(:a, :b, :matcher) do
          [
            [1    , 2     , eq(3) ],
            [five , eight , eq_matcher],
          ]
        end

        with_them do
          it "a plus b is answer" do
            expect(a + b).to matcher
          end
        end
      end
    end
  end
end
