class SearchRecipe

  def basic_search(num)
    search_parameters = "&q=main%20dishes" + max_results(num) + must_be_salty
    recipes = get_response(search_parameters)
    recipes['matches'].map {|recipe| recipe['id'] }
  end

  def get_attributes(search_results)
    full_recipes = get_full_recipe_data(search_results)
    format_recipe_data(full_recipes)
  end

  def get_full_recipe_data(recipe_ids)
    recipe_ids.map do |id|
      GetRecipe.new.get_response(id)
    end
  end

  def format_recipe_data(full_recipes)
    full_recipes.map do |recipe|
      {name: recipe['name'], total_time: recipe['totalTime'], seconds: recipe['totalTimeInSeconds'], source: recipe['source']["sourceRecipeUrl"], servings: recipe['numberOfServings'], images: recipe['images'], ingredients: recipe['ingredientLines']}
    end
  end

  # ["attribution", "ingredientLines", "flavors", "nutritionEstimates", "images", "name", "yield", "totalTime", "attributes", "totalTimeInSeconds", "rating", "numberOfServings", "source", "id"]""

  def get_url(search_parameters)
    "http://api.yummly.com/v1/api/recipes?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}&#{search_parameters}"
  end

  #keys = ["smallImageUrls", "ingredients", "flavors", "imageUrlsBySize", "attributes", "totalTimeInSeconds", "rating", "recipeName", "sourceDisplayName", "id"]

  def get_response(search_parameters)
    url = get_url(search_parameters)
    response = Faraday.get(url)
    JSON.parse(response.body)
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

#Acceptable Diets are: pescetarian, vegan, vegetarian, lacto (lacto-vegetarian), ovo (ovo-vegetarian)

  def diet_restrictions(*args)
    codes = args.map do |arg|
      diet = Diet.where("name like ?", "%#{arg.capitalize}%")
      if diet.any?
        diet.first.yummly_code
      end
    end
    formatted_codes = codes.map {|code| if code then "&allowedDiet[]=" + code end}
  formatted_codes.join("")
  end

  def included_courses
    "&includedCourse[]=course^course-Main Dishes&includedCourse[]=course^course-Salads&includedCourse[]=course^course-Soups"
  end

  def max_results(num)
    "&maxResult=#{num}&start=10"
  end

  def must_be_salty
    "&flavor.salty.min=0.1"
  end

  def remove_spaces(string)
    string.gsub(" ", "%20")
  end

end
