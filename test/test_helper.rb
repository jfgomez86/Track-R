require 'rubygems'
require 'shoulda'
require 'yaml'
require 'test/unit'
require File.join(File.dirname(__FILE__), '/../lib/track-r.rb')
require File.join(File.dirname(__FILE__), '/../config/environment.rb')
$config = YAML.load_file(File.join(File.dirname(__FILE__), '/test_config.yml'))
