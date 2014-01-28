class SearchRecipe

  def get_url(search_parameters)
    "http://api.yummly.com/v1/api/recipes?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}&#{search_parameters}"
  end

  def allowed_ingredients(*args)
    formatted_ingredients = args.map {|arg| "&allowedIngredient[]=" + arg}
    remove_spaces(formatted_ingredients.join(""))
  end

  def excluded_ingredients(*args)
    formatted_ingredients = args.map {|arg| "&excludedIngredient[]=" + arg}
    remove_spaces(formatted_ingredients.join(""))
  end

  def allergies(*args)

  end

  def diet_restrictions(*args)

  end

  def type_category

  end

  def remove_spaces(string)
    string.gsub(" ", "%20")
  end

end
