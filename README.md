# RSpec::Parameterized [![Gem Version](https://badge.fury.io/rb/rspec-parameterized.svg)](https://badge.fury.io/rb/rspec-parameterized) ![rspec](https://github.com/tomykaira/rspec-parameterized/actions/workflows/rspec.yml/badge.svg)

Support simple parameterized test syntax in rspec.

```ruby
# Nested Array Style
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
      expect(a + b).to eq answer
    end
  end

  with_them do
    # Can browse parameters via `params` method in with_them block
    # Can browse all parameters via `all_params` method in with_them block
    it "#{params[:a]} + #{params[:b]} == #{params[:answer]}" do
      expect(a + b).to eq answer
    end
  end
end

# Hash and Array Style
# Given parameters is each value combinations
# On this case
# [
#   [1, 5, 2],
#   [1, 5, 4],
#   [1, 7, 2],
#   [1, 7, 4],
#   [1, 9, 2],
#   [1, 9, 4],
#   [3, 5, 2],
#   [3, 5, 4],
#   [3, 7, 2],
#   [3, 7, 4],
#   [3, 9, 2],
#   [3, 9, 4]
# ]
describe "Hash arguments" do
  where(a: [1, 3], b: [5, 7, 9], c: [2, 4])

  with_them do
    it "sums is even" do
      expect(a + b + c).to be_even
    end
  end
end

# Table Syntax Style (like Groovy spock)
# Need ruby-2.1 or later
describe "plus" do
  using RSpec::Parameterized::TableSyntax

  where(:a, :b, :answer) do
    1 | 2 | 3
    5 | 8 | 13
    0 | 0 | 0
  end

  with_them do
    it "should do additions" do
      expect(a + b).to eq answer
    end
  end
end

# Verbose Syntax
# For complex inputs or if you just want to be super explicit
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
  end
end

# It's also possible to override each combination name using magic variable :case_name
# Output:
# Custom names for regular syntax
#   positive integers
#     should do additions
#   negative integers
#     should do additions
#   mixed integers
#     should do additions
describe "Custom names for regular syntax" do
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
  end
end

# Or :case_names lambda for hash syntax
# Output:
# Custom naming for hash syntax
#   1 + 5 + 2
#     sum is even
#   1 + 5 + 4
#     sum is even
#   1 + 7 + 2
#     sum is even
#   ...
describe "Custom naming for hash syntax" do
  where(case_names: ->(a, b, c){"#{a} + #{b} + #{c}"}, a: [1, 3], b: [5, 7, 9], c: [2, 4])

  with_them do
    it "sum is even" do
      expect(a + b + c).to be_even
    end
  end
end

# Use ref(:symbol) to use let/let! defined variables in the where block
# Use lazy when you want to create let/let! variables after the where block
#
# Failures will be more readable in the future - https://github.com/tomykaira/rspec-parameterized/pull/65
describe "lazy and ref types" do
  let(:one) { 1 }
  let(:four) { 4 }

  where(:a, :b, :result) do
    [
      [ref(:one), ref(:four), lazy { two + three }]
    ]
  end

  with_them do
    context "use let after where block" do
      let(:two) { 2 }
      let(:three) { 3 }

      it 'should equal 5' do
        expect(a + b).to eq result
      end
    end
  end
end
```

I was inspired by [udzura's mock](https://gist.github.com/1881139).

## Support Versions

Ruby-2.6.0 or later.

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-parameterized'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-parameterized

## Usage

Require `rspec-parameterized` from your `spec_helper.rb`.

    require 'rspec-parameterized'

Follow the sample spec above.

Arguments given to `with_them` is directly passed to `describe`.  You can specify `:pending`, `:focus`, etc. here.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
