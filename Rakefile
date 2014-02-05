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
  cmds = []
  cmds << "git tag -a v#{SinatraSimpleRouter::VERSION} -m 'Tagging #{SinatraSimpleRouter::VERSION}'"
  cmds << "git push --tags"
  cmds << "gem push sinatra_simple_router-#{SinatraSimpleRouter::VERSION}.gem"
  cmds << "rm *.gem"
  system cmds.join(' && ')
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
