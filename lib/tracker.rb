$:.unshift(File.dirname(__FILE__))
require File.join(File.dirname(__FILE__), '/../config/environment.rb')
require 'tracker/project'
require 'tracker/story'
require 'tracker/token'
require 'tracker/tracker'

# Load configuration globals
CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), '/../config/config.yml'))
