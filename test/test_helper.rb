gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require File.dirname(__FILE__) + '/../app'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
