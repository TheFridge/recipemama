class SearchRecipe

  def complex_search(formatted_array)
    search_parameters = make_url_array(formatted_array)
    url_params = search_parameters.join + max_results(50)
    response = get_response(url_params)
  end

  def basic_search(num)
    search_parameters = "&q=main%20dishes" + max_results(num) + must_be_salty
    recipes = get_response(search_parameters)
    recipes['matches'].map {|recipe| {'yummly_id' => recipe['id'], 'ingredients' => recipe['ingredients'] }}
  end

  def get_attributes(search_results)
    full_recipes = get_full_recipe_data(search_results)
    format_recipe_data(full_recipes)
  end

  def get_full_recipe_data(search_results)
    search_results.map do |result|
      get_recipe_call = GetRecipe.new
      {'recipe' => get_recipe_call.get_response(result['yummly_id']), 'ingredients' => result['ingredients']}
    end
  end

  def format_recipe_data(full_recipes)
    full_recipes.map do |recipe|
      { basic_ingredients: [''], name: recipe['recipe']['name'], total_time: recipe['recipe']['totalTime'], seconds: recipe['recipe']['totalTimeInSeconds'], source_url: recipe['recipe']['source']["sourceRecipeUrl"], servings: recipe['recipe']['numberOfServings'], images: recipe['recipe']['images'], ingredients: recipe['recipe']['ingredientLines'], yummly_id: recipe['recipe']['id']}
    end
  end

  def format_ingredient_parameters(recipe_array)
    formatted_array = recipe_array.map do |ingredient|
      formatted_ingredient = GroceryListFormatter.check_name(ingredient)
      formatted_ingredient.downcase if formatted_ingredient
    end
    formatted_array
  end

  def make_url_array(formatted_array)
    url_array = formatted_array.map do |string|
      allowed_ingredients(string)
    end
    url_array
  end

  def format_one_recipe(recipe)
    #recipe
    array = {:name => recipe["name"], :total_time => recipe['totalTime'], 
      :seconds => recipe['totalTimeInSeconds'], :source_url => recipe['attribution']['url'], 
      :images => recipe['images'], :servings => recipe['numberOfServings'], 
      :yummly_id => recipe['id'], :basic_ingredients => [], :ingredients => recipe['ingredientLines']}
    pull_basic_ingredients(array)
  end

  def pull_basic_ingredients(array)
    array[:ingredients].each do |raw_ingredient|
      formatted_raw = Ingreedy.parse(raw_ingredient)
      array[:basic_ingredients] << formatted_raw.ingredient
    end
    array
  end

  # ["attribution", "ingredientLines", "flavors", "nutritionEstimates", "images", "name", "yield", "totalTime", "attributes", "totalTimeInSeconds", "rating", "numberOfServings", "source", "id"]""

  def get_url(search_parameters)
    "http://api.yummly.com/v1/api/recipes?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}&#{search_parameters}"
  end

  #keys = ["smallImageUrls", "ingredients", "flavors", "imageUrlsBySize", "attributes", "totalTimeInSeconds", "rating", "recipeName", "sourceDisplayName", "id"]

  def get_response(search_parameters)
    url = get_url(search_parameters)
    response = Faraday.get(url)
    if response.status == 409
      {'error' => 'erroneous'}
    else
      JSON.parse(response.body)
    end
  end

  def get_array_response(array)
    param_array = array.map do |ingredient|
      allowed_ingredients(ingredient)
    end
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
