require "bundler"
Bundler.setup

require "bundler/gem_tasks"
require "rspec/core/rake_task"

task :build do
  system "gem build simple_router.gemspec"
end

task :install => :build do
  system "gem install pkg/simple_router-#{SimpleRouter::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec

