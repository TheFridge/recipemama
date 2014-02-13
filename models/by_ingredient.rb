class ByIngredient

  def self.read_params(params_body)
    params_array = params_body['ingredients']
  end

  def self.get_one_ingredient(formatted_array)
    formatted_array.shuffle.shift(1)
  end

  def self.get_yummly_response(formatted_array)
    search = SearchRecipe.new
    three_ingredients = formatted_array.shuffle.shift(3)
    response = search.complex_search(three_ingredients)
  end

  def self.get_internal_ingredient(one_ingredient)
    Ingredient.find_by("description like ?", "%#{one_ingredient}%")
  end

  def self.handle_errors(response)

  end


  def self.format_ingredient_parameters(recipe_array)
    formatted_array = recipe_array.map do |ingredient|
      formatted_ingredient = GroceryListFormatter.check_name(ingredient)
      formatted_ingredient.downcase if formatted_ingredient
    end
    formatted_array.compact!
  end
end
