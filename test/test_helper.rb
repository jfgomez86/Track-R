require 'rubygems'
require 'shoulda'
require 'test/unit'
require File.join(File.dirname(__FILE__), '/../lib/tracker.rb')
require File.join(File.dirname(__FILE__), '/../config/environment.rb')
$config = YAML.load_file(File.join(File.dirname(__FILE__), '/test_config.yml'))
