require "bundler"
Bundler.setup

require "bundler/gem_tasks"
require "rspec/core/rake_task"

task :build do
  system "gem build sinatra_simple_router.gemspec"
end

task :install => :build do
  system "gem install pkg/sinatra_simple_router-#{SinatraSimpleRouter::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{SinatraSimpleRouter::VERSION} -m 'Tagging #{SinatraSimpleRouter::VERSION}'"
  system "git push --tags"
  system "gem push sinatra_simple_router-#{SinatraSimpleRouter::VERSION}.gem"
  system "rm *.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec