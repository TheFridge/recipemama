class GetRecipe

  def get_url(recipe_id)
    "http://api.yummly.com/v1/api/recipe/#{recipe_id}?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}"
  end

end
