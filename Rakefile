require "bundler"
require "rspec/core/rake_task"
require "rake/extensiontask"

Rake::ExtensionTask.new('narray') do |ext|
  ext.lib_dir = File.join('lib', 'narray')
end
Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)

desc "Run unit tests"
task :unit_tests do
  ruby "-I.:lib test/unit_tests.rb"
end

Rake::Task['spec'].prerequisites << :compile

task :default => [:spec]
