# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec/parameterized/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["tomykaira"]
  gem.email         = ["tomykaira@gmail.com"]
  gem.description   = %q{RSpec::Parameterized supports simple parameterized test syntax in rspec.}
  gem.summary       = %q{RSpec::Parameterized supports simple parameterized test syntax in rspec.
I was inspired by [udzura's mock](https://gist.github.com/1881139).}
  gem.homepage      = ""

  gem.add_dependency('rspec', '>= 2.13', '< 4')
  gem.add_dependency('parser')
  gem.add_dependency('unparser')
  gem.add_dependency('proc_to_ast')
  gem.add_development_dependency('rake')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rspec-parameterized"
  gem.require_paths = ["lib"]
  gem.version       = RSpec::Parameterized::VERSION
end
