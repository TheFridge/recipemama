class SearchRequestTest < Minitest::Test

  def setup
    @searchrecipe = SearchRecipe.new
  end

  def test_allowed_ingredients_formats_correctly
    assert_equal "&allowedIngredient[]=garlic&allowedIngredient[]=cognac", @searchrecipe.allowed_ingredients('garlic', 'cognac')
    assert_equal "&allowedIngredient[]=onion%20soup%20mix&allowedIngredient[]=cognac", @searchrecipe.allowed_ingredients('onion soup mix', 'cognac')
  end

  def test_excluded_ingredients_formats_correctly
    assert_equal "&excludedIngredient[]=garlic&excludedIngredient[]=cognac", @searchrecipe.excluded_ingredients('garlic', 'cognac')
  end

  # def test_render_ingredients
  #   VCR.use_cassette('toad-in-the-hole') do
  #     assert_equal "Cookie Cutter Toad-in-the-Hole", @getrecipe.get_response('Cookie-Cutter-Toad-in-the-Hole-496678')['id']
  #   end
  # end

end
