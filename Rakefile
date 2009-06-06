require 'rubygems'
begin
  require 'rake'
  require 'rake/testtask'
rescue LoadError
  puts 'This script should only be accessed via the "rake" command.'
  puts 'Installation: gem install rake -y'
  exit
end
require 'rake/clean'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose    = true
  t.warning    = true
  t.options    = '--runner=gtk2'
end
