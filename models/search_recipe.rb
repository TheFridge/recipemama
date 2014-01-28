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

#Acceptable allergies are: "wheat, gluten, peanut, tree, dairy, egg, seafood, sesame, soy, sulfite"

  def allergies(*args)
    codes = args.map do |arg|
      allergy = Allergy.where("name like ?", "%#{arg.capitalize}%")
      if allergy.any?
        allergy.first.yummly_code
      end
    end
    formatted_codes = codes.map {|code| if code then "&allowedAllergy[]=" + code end}
    formatted_codes.join("")  
  end

  def diet_restrictions(*args)

  end

  def type_category

  end

  def remove_spaces(string)
    string.gsub(" ", "%20")
  end

end
