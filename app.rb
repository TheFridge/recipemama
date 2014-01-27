require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'json'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

get '/' do
  'hello'
end
