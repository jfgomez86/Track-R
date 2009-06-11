#!/usr/bin/env ruby
#-------------------------------------------------------------------------------.
# InstallGems: Script to do the hard gem installing and letting you rest a bit. ||
#                                                                               ||
# AUTHOR: Jose F. Gomez                                                         ||
# VERSION: 0.2.0                                                                ||
# DATE: 2009-04-04                                                              ||
#                                                                               ||
# USAGE: install-gems.rb [file.yml] The yml file should have this format per    ||
# gem:                                                                          ||
#                                                                               ||
# example.yml:                                                                  ||
# ---                                                                           ||
# - :source: http://gems.github.com                                             ||
#   :version: = 0.1.99.21                                                       ||
#   :name: aslakhellesoy-cucumber                                               ||
#                                                                               ||
# Note that :source and :version are optional and the script checks wheter a    ||
# gem is already installed or not.                                              ||
#                                                                               ||
#-------------------------------------------------------------------------------´
#  HISTORY
#  0.2.0  -- Made script require-able.
#  0.1.0  -- Initial Commit


class InstallGems
  require 'yaml'
  require 'rubygems'

  def initialize(file)
    @gems_yml = YAML.load_file(file)
    install_gems
  end

  def install_gems
    for gem in @gems_yml
      install_gem(gem)
    end
  end

  def install_gem(gem)
    unless Gem.available? gem[:name]
      cmd = "gem install "
      cmd += "--version '%s' " % gem[:version] if gem.has_key? :version
      cmd += "--source %s " % gem[:source] if gem.has_key? :source
      cmd += "%s " % gem[:name] if gem.has_key? :name
      puts "Installing: %+28s"  % gem[:name]
      out = %x[#{cmd}]
    else
      puts "*** [ #{gem[:name]} ] is already installed on this system."
    end
  end
end

if __FILE__ == $0
  app = InstallGems.new(ARGV[0])
end

#-------------------------------------------------------------------------------.
# vim: set foldmethod:indent                                                    ||
#-------------------------------------------------------------------------------´

