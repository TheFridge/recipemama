gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'faraday'
require 'vcr'

ENV['RACK_ENV'] = 'test'

require File.dirname(__FILE__) + '/../app'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

VCR.configure do |c|
  c.cassette_library_dir = './cassettes'
  c.hook_into :faraday
end
