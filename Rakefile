$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '/vendor/')
require 'rubygems'
require 'rake/gempackagetask'

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
  t.warning    = false
  #t.options    = '--runner=gtk2'
end

namespace :gems do
  desc "Install gems listed in config/gems.yml"
  task :install do
    if !`whoami`.match(/root/)
      print "WARNING: You should be running this as root.\n"
      print "Do you want to continue?(y/N) "
      opt  = STDIN.gets
      fail "Not authorized" unless opt.match(/^y/i)
    end
    require 'install-gems/install-gems.rb'
    InstallGems.new(File.join(File.dirname(__FILE__),'/config/gems.yml'))
  end
end

spec = Gem::Specification.new do |s|
    s.platform     = Gem::Platform::RUBY
    s.name         = "track-r"
    s.description  = "track-r is a library that provides wrapper classes and methods for accessing PivotalTracker's public API."
    s.homepage     = "http://github.com/jfgomez86/Track-R"
    s.version      = "1.0.0"
    s.author       = "Jose Felix Gomez"
    s.email        = "moc.liamg@68zemogfj".reverse
    s.summary      = "A wrapper library for pivotal tracker's API"
    s.files        = Dir.glob('{config,lib}/**/*.{rb,yml}')
    s.require_path = "lib"
    s.test_files   = Dir.glob('test/**/*.rb') << "test/test_config.yml.example"
    s.has_rdoc     = true
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
end

namespace :gem do
  task :build => "pkg/#{spec.name}-#{spec.version}.gem" do
    puts "generated latest version"
  end
end
