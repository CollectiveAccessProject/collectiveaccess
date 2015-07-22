# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'collectiveaccess'
  gem.homepage = 'http://github.com/CollectiveAccessProject/collectiveaccess'
  gem.license = 'GPL3'
  gem.summary = 'Ruby wrapper for CollectiveAccess Web Service API'
  gem.description = 'This gem is a simple plain Ruby wrapper for the CollectiveAccess Web Service API. For more info see https://github.com/CollectiveAccessProject/collectiveaccess'
  gem.email = 'info@collectiveaccess.org'
  gem.authors = %w(CollectiveAccess Stefan)
  gem.required_ruby_version = '>= 1.9.3'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc 'Code coverage detail'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : '0.0.1'

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "collectiveaccess #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
