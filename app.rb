require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'json'
require 'faraday'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

get '/' do
  @recipe = GiveRecipe.generate_random
  {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
end

get '/:id' do
  @recipe = GiveRecipe.generate_from_id(params[:id])
  {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
end

