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

post '/by_ingredient' do
  params_body = JSON.parse(request.body.read)
  raw_ingredients = ByIngredient.read_params(params_body).dup
  formatted_ingredients = ByIngredient.format_ingredient_parameters(raw_ingredients)
  ingredient_count = formatted_ingredients.count
  #response = ByIngredient.get_yummly_response(formatted_ingredients)
  one_ingredient = ByIngredient.get_one_ingredient(formatted_ingredients)
  #if response['error']
  internal_ingredient = ByIngredient.get_internal_ingredient(one_ingredient)
  if internal_ingredient
    @internal_recipe = internal_ingredient.recipe
  else
    @internal_recipe = GiveRecipe.generate_random
  end
  {recipe: @internal_recipe, ingredients: @internal_recipe.ingredients}.to_json
    #if internal_ingredient
  #end 
  #   if @internal_recipe
  #     {recipe: @internal_recipe, ingredients: @internal_recipe.ingredients}.to_json
  #   else
  #   {:error_message => "no matches for "}.to_json
  #   end
  # else
  #   until response['matches'].any? || ingredient_count == 0
  #     formatted_array.pop
  #     response = search.complex_search(formatted_array)
  #   end
  #   response_count = response['matches'].count
  #   number = rand(0..response_count - 1)
  #   if response['matches'].count > 0
  #     id = response['matches'][number]['id']
  #     get = GetRecipe.new
  #     raw_recipe = get.get_response(id)
  #     formatted_recipe = search.format_one_recipe(raw_recipe)
  #     @recipe = Recipe.new
  #     @recipe.create_recipe(formatted_recipe)
  #     {recipe: Recipe.last, ingredients: Recipe.last.ingredients}.to_json
  #   else
  #     @internal_recipe = Recipe.last#find_by("ingredient_list like ?", "%#{@one_ingredient}%")
  #     if @internal_recipe
  #       {recipe: @internal_recipe, ingredients: @internal_recipe.ingredients}.to_json
  #     else
  #       {:error_message => "no matches for"}.to_json
  #     end
  #  end
  # end
end

get '/:id' do
  @recipe = GiveRecipe.generate_from_id(params[:id])
  {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
end

get '/ping/ping' do
  'PONG'
end

#curl --data "ingredient=milk" http://localhost:4567/by_ingredient

# post '/by_ingredient' do
  # search = SearchRecipe.new
  # @ingredient_array = search.format_ingredient_parameters(params[:ingredient])
  # @ingredient_array.compact!
  # parameters = search.allowed_ingredients(@ingredient) + search.max_results(50)
  # url = search.get_response(parameters)
  # number = rand(0..url['matches'].count - 1)
  # if url['matches'].count > 0
  #   id = url['matches'][number]['id']
  #   get = GetRecipe.new
  #   raw_recipe = get.get_response(id)
  #   formatted_recipe = search.format_one_recipe(raw_recipe)
  #   @recipe = Recipe.new
  #   @recipe.create_recipe(formatted_recipe)
  #   {recipe: @recipe, ingredients: @recipe.ingredients}.to_json
  # else
  #   @internal_recipe = Recipe.find_by("ingredient_list like ?", "%#{@ingredient}%")
  #   if @internal_recipe
  #     {recipe: @internal_recipe.first, ingredients: @internal_recipe.first.ingredients}.to_json
  #   else
  #     {:error_message => "no matches for #{@ingredient}"}.to_json
  #   end
  # end

# end
