gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require "minitest/reporters"
Minitest::Reporters.use!

ENV['RACK_ENV'] = 'test'

require File.dirname(__FILE__) + '/../app'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
