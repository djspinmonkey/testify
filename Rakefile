require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "testify"
    gem.summary = %Q{Testify is a test framework framework.  Think "Rack for testing."}
    #gem.description = %Q{TODO: longer description of your gem}
    gem.email = "github@djspinmonkey.com"
    gem.homepage = "http://github.com/djspinmonkey/testify"
    gem.authors = ["John Hyland"]
    gem.add_dependency "classy", ">= 1.0.0"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

RSpec::Core::RakeTask.new do |t|
end

RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

task :spec

task :default => :spec

# This is generating some annoying warnings - commented out for now until I
# figure out how to quiet it down.
#
#require 'rdoc/task'
#RDoc::Task.new do |rdoc|
#  version = File.exist?('VERSION') ? File.read('VERSION') : ""
#
#  rdoc.rdoc_dir = 'rdoc'
#  rdoc.title = "testify #{version}"
#  rdoc.rdoc_files.include('README*')
#  rdoc.rdoc_files.include('lib/**/*.rb')
#end
