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

    with_them do
      it "#{params[:a]} + #{params[:b]} == #{params[:answer]}" do
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

  describe "Verbose syntax" do
    where do
      {
        "positive integers" => {
          a: 1,
          b: 2,
          answer: 3,
        },
        "negative_integers" => {
          a: -1,
          b: -2,
          answer: -3,
        },
        "mixed_integers" => {
          a: 3,
          b: -3,
          answer: 0,
        },
      }
    end

    with_them do
      it "should do additions" do
        expect(a + b).to eq answer
      end

      it "should have custom name" do |example|
        expect(example.metadata[:example_group][:description]).to eq case_name
      end
    end

    context "lambda parameter" do
      where do
        {
          "integers" => {
            a: 1,
            b: 2,
            answer: -> {expect(subject).to eq 3},
          },
          "strings" => {
            a: "hello ",
            b: "world",
            answer: -> {expect(subject).to include "lo wo"},
          },
          "arrays" => {
            a: [1, 2, 3],
            b: [4, 5, 6],
            answer: -> {expect(subject.size).to eq 6}
          }
        }
      end

      with_them do
        subject {a + b}
        it "should do additions" do
          self.instance_exec(&answer)
        end

        it "should have custom name" do |example|
          expect(example.metadata[:example_group][:description]).to eq(case_name)
        end
      end
    end
  end

  describe "Custom test case name" do
    context "when regular arguments" do
      where(:case_name, :a, :b, :answer) do
        [
          ["positive integers",  6,  2,  8],
          ["negative integers", -1, -2, -3],
          [   "mixed integers", -5,  3, -2],
        ]
      end

      with_them do
        it "should do additions" do
          expect(a + b).to eq answer
        end

        it "should have custom test name" do |example|
          expect(example.metadata[:example_group][:description]).to eq case_name
        end
      end
    end

    context "when hash arguments" do
      where(case_names: ->(a, b, c){"#{a} + #{b} + #{c}"}, a: [1, 3], b: [5, 7, 9], c: [2, 4])

      with_them do
        it "sum is even" do
          expect(a + b + c).to be_even
        end

        it "should have custom names" do |example|
          expect(example.metadata[:example_group][:description]).to include "+"
        end
      end
    end

    if RUBY_VERSION >= "2,1"
      context "when arguments are separated with pipe (using TableSyntax)" do
        using RSpec::Parameterized::TableSyntax

        where(:case_name, :a, :b, :answer) do
          "integers"      | 1                     | 2                     | 3
          "strings"       | "hello "              | "world"               | "hello world"
          "arrays"        | [1, 2, 3]             | [4, 5, 6]             | [1, 2, 3, 4, 5, 6]
          "giant numbers" | 100000000000000000000 | 100000000000000000000 | 200000000000000000000
        end

        with_them do
          it "a plus b is answer" do
            expect(a + b).to eq answer
          end

          it "should have custom test name" do |example|
            expect(example.metadata[:example_group][:description]).to eq case_name
          end
        end
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
        100000000000000000000 | 100000000000000000000 | 200000000000000000000
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
        100000000000000000000 | 100000000000000000000 | -> { eq(200000000000000000000) }
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
