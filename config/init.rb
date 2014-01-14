SINATRA_ROOT = File.dirname(File.dirname(__FILE__))

require 'sinatra/activerecord'
require './config/environments' #DB CONFIG
require 'rubygems'
require 'bundler/setup'
require 'logger'

Bundler.require(:default)

class String
  def underscore_to_camelcase
    words = split('_').map!{|w| w.capitalize}
    words.join
  end
end

# INITIALIZE AUTO LOADERS
autoload_targets = ['lib', 'controllers', 'models', 'helpers', 'init']

autoload_targets.each do |folder|
  files = Dir.entries(File.join(SINATRA_ROOT, folder)).reject! {|file| file.start_with?('.') }
  files.each do |f|
    require "./#{folder}/#{f}"
  end
end

# CONFIGURE LOGGER
LOG = Logger.new('log/hansel.log')
LOG.debug "Your server just got cheesed bro. [Server Booted]"
	# LOG.error "This will not be ignored"