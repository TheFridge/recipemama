require './app'
run Sinatra::Application

ENV['RACK_ENV'] ||= 'development'
