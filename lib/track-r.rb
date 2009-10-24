# Load configuration globals
require 'yaml'
CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), '/../config/config.yml'))
$:.unshift(File.dirname(__FILE__))
require File.join(File.dirname(__FILE__), '/../config/environment.rb')
require 'track-r/project'
require 'track-r/story'
require 'track-r/comment'
require 'track-r/token'
require 'track-r/tracker'
require 'cgi'
require 'net/http'
require 'net/https'
