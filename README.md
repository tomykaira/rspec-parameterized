# RSpec::Parameterized [![Build Status](https://travis-ci.org/tomykaira/rspec-parameterized.svg)](https://travis-ci.org/tomykaira/rspec-parameterized)

Support simple parameterized test syntax in rspec.

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

I was inspired by [udzura's mock](https://gist.github.com/1881139).

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
