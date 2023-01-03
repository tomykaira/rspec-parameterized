# v1.0
Moved all implements to https://github.com/rspec-parameterized/rspec-parameterized-core and https://github.com/rspec-parameterized/rspec-parameterized-table_syntax

For v0.x users, there is basically no need to do anything other than `bundle update`.

If you are not using `RSpec::Parameterized::TableSyntax`, you can write `rspec-parameterized-core` instead of `rspec-parameterized` in your `Gemfile` to reduce the dependency. (`rspec-parameterized-table_syntax` includes dependency on native extension...)

e.g.

```ruby
# Before
gem "rspec-parameterized"

# After
gem "rspec-parameterized-core"
```
