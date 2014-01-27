require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

get '/' do
  'hello'
end
