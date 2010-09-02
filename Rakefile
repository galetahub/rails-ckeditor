# encoding: utf-8
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'ckeditor', 'version')

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the rails-ckeditor plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the rails-ckeditor plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Rails Ckeditor'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.textile')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "ckeditor"
    gemspec.version = Ckeditor::Version.dup
    gemspec.summary = "Rails plugin for integration ckeditor 3.x"
    gemspec.description = "CKEditor is a WYSIWYG editor to be used inside web pages"
    gemspec.email = "galeta.igor@gmail.com"
    gemspec.homepage = "http://github.com/galetahub/rails-ckeditor"
    gemspec.authors = ["Igor Galeta"]
    gemspec.files = FileList["[A-Z]*", "{app,config,lib}/**/*"]
    gemspec.rubyforge_project = "ckeditor"
    
    gemspec.add_dependency('mime-types', '>= 1.16')
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
