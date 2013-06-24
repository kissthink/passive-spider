class Environment

  def self.require_all
  	require_libs
  	require_pspider
  	require_gems
  end

  def self.require_libs
    require 'base64'
    require 'getoptlong'
    require 'uri'
    require 'socket'
  end

  def self.require_pspider
    require_relative 'helper'
    require_relative 'config'
    require_relative 'output'
    require_relative '../modules/helper'
    require_relative '../modules/bing'
  end

  def self.require_gems
    begin
      require 'typhoeus'
      require 'json'
    rescue => e
      puts '[ERROR] Missing gems. Try: gem install bundler && bundle install'
      exit
    end
  end

end