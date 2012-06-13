require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake'
$:.unshift  File.join(File.dirname(__FILE__), "lib")
 
require 'rspec/core'
require 'rspec/core/rake_task'
 
task :default => :spec
 
desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec)
