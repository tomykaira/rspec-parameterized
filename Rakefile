#!/usr/bin/env rake
require "bundler/gem_tasks"

task :default => [:spec]
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rspec_opts = ['-c -f d']
  end
end

namespace :spec do
  %w(rspec2 rspec3).each do |gemfile|
    desc "Run Tests by #{gemfile}.gemfile"
    task gemfile do
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle install --path .bundle"
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle exec rake -t spec"
    end
  end

  desc "Run All Tests"
  task :all do
    %w(rspec2 rspec3).each do |gemfile|
      Rake::Task["spec:#{gemfile}"].invoke
    end
  end
end
