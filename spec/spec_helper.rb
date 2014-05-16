require 'rspec-parameterized'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :current
end
