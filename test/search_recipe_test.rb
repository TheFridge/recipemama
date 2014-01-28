class SearchRequestTest < Minitest::Test

  def setup
    DatabaseCleaner.start
    Key.create(application_id: ENV['YUMMLY_ID'], application_keys: ENV['YUMMLY_KEY'])
    @searchrecipe = SearchRecipe.new
  end

  def test_allowed_ingredients_formats_correctly
    assert_equal "&allowedIngredient[]=garlic&allowedIngredient[]=cognac", @searchrecipe.allowed_ingredients('garlic', 'cognac')
    assert_equal "&allowedIngredient[]=onion%20soup%20mix&allowedIngredient[]=cognac", @searchrecipe.allowed_ingredients('onion soup mix', 'cognac')
  end

  def test_excluded_ingredients_formats_correctly
    assert_equal "&excludedIngredient[]=garlic&excludedIngredient[]=cognac", @searchrecipe.excluded_ingredients('garlic', 'cognac')
  end

  def test_allergies_formats_correctly
    allergies = @searchrecipe.allergies("gluten")
    assert_equal "&allowedAllergy[]=393^Gluten-Free", allergies
  end

  def test_diets_formats_correctly
    VCR.use_cassette('generate_diets') do
      Diet.generate_diets
      diets = @searchrecipe.diet_restrictions("pescetarian")
      assert_equal "&allowedDiet[]=390^Pescetarian", diets
    end
  end

  def test_allergies_handles_multiple_allergies
    VCR.use_cassette('generate_allergies') do
      Allergy.generate_allergies
      allergies = @searchrecipe.allergies("egg", "gluten")
      assert_equal "&allowedAllergy[]=397^Egg-Free&allowedAllergy[]=393^Gluten-Free", allergies
    end
  end

  def test_allergies_handles_unused_allergies
    allergies = @searchrecipe.allergies("people")
    assert_equal "", allergies
  end

  # def test_render_ingredients
  #   VCR.use_cassette('toad-in-the-hole') do
  #     assert_equal "Cookie Cutter Toad-in-the-Hole", @getrecipe.get_response('Cookie-Cutter-Toad-in-the-Hole-496678')['id']
  #   end
  # end

  def teardown
    DatabaseCleaner.clean
  end

end
