
require 'rubygems'
require 'rake'
require 'rake/testtask'
require File.expand_path('../lib/crankshaft/version', __FILE__)

namespace :test do
  Rake::TestTask.new(:all) do |test|
    test.libs      << 'lib' << 'test'
    test.pattern   = 'test/**/*.rb'
    test.verbose   = true
  end
end

task :test do
  Rake::Task['test:all'].invoke
end

task :default => :test

desc 'Builds the gem'
task :build do
  sh "gem build crankshaft.gemspec"
end

desc 'Builds and installs the gem'
task :install => :build do
  sh "gem install crankshaft-#{Crankshaft::Version}"
end
