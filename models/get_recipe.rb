class GetRecipe

  def get_url(recipe_id)
    "http://api.yummly.com/v1/api/recipe/#{recipe_id}?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}"
  end

  def get_response(recipe_id)
    url = get_url(recipe_id)
    response = Faraday.get(url)
    JSON.parse(response.body)
  end

end
