# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec/parameterized/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["tomykaira"]
  gem.email         = ["tomykaira@gmail.com"]
  gem.description   = %q{RSpec::Parameterized supports simple parameterized test syntax in rspec.}
  gem.summary       = %q{RSpec::Parameterized supports simple parameterized test syntax in rspec.
I was inspired by [udzura's mock](https://gist.github.com/1881139).}
  gem.homepage      = "https://github.com/tomykaira/rspec-parameterized"

  gem.metadata["rubygems_mfa_required"] = "true"
  gem.license       = "MIT"

  gem.add_dependency('rspec-parameterized-core', '< 2')
  gem.add_dependency('rspec-parameterized-table_syntax', '< 2')

  gem.add_development_dependency('rake', '>= 12.0.0')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rspec-parameterized"
  gem.require_paths = ["lib"]
  gem.version       = RSpec::Parameterized::VERSION
end
