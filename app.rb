require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'json'
require 'faraday'
require 'ingreedy'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

get '/' do
  @recipe = GiveRecipe.generate_random
  {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
end

get '/:id' do
  @recipe = GiveRecipe.generate_from_id(params[:id])
  {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
end

#curl --data "ingredient=milk" http://localhost:4567/by_ingredient

post '/by_ingredient' do
  search = SearchRecipe.new
  @ingredient = search.format_ingredient_parameters(params[:ingredient])
  parameters = search.allowed_ingredients(@ingredient) + search.max_results(50)
  url = search.get_response(parameters)
  number = rand(0..url['matches'].count - 1)
  if url['matches'].count > 0
    id = url['matches'][number]['id']
    get = GetRecipe.new
    raw_recipe = get.get_response(id)
    formatted_recipe = search.format_one_recipe(raw_recipe)
    @recipe = Recipe.new
    @recipe.create_recipe(formatted_recipe)
    {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
  else
    {:error_message => "no matches for #{@ingredient}"}.to_json
  end

end
