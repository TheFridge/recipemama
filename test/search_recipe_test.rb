require_relative './test_helper'

class SearchRequestTest < Minitest::Unit::TestCase

  def setup
    Key.create(application_id: ENV['YUMMLY_ID'], application_keys: ENV['YUMMLY_KEY'])
    @searchrecipe = SearchRecipe.new
  end

  def test_generate_recipe
    VCR.use_cassette('new_recipe', :record => :new_episodes) do
      assert_equal 0, Ingredient.all.count
      assert_equal 0, Recipe.all.count
      search_results = @searchrecipe.basic_search(1)
      answer = @searchrecipe.get_attributes(search_results).first
      Recipe.new.create_recipe(answer)
      assert_equal 1, Recipe.all.count
      assert_equal 17, Ingredient.all.count
      assert_equal Recipe.first.id, Ingredient.first.recipe_id
    end
  end

  def test_basic_search
    VCR.use_cassette('basic_search') do
      assert_equal 50, @searchrecipe.basic_search(50).count
    end
  end

  def test_basic_search_response
    VCR.use_cassette('basic_search2') do
      result = [{"yummly_id"=>"Slow-cooker-lemon-honey-and-dijon-chicken-dinner-334881", "ingredients"=>["boneless, skinless chicken breasts", "reduced sodium chicken broth", "pearl onions", "garlic", "dijon mustard", "kosher salt", "lemon", "red potato", "chopped parsley", "honey", "ground black pepper", "haricots verts", "thyme leaves"]}]
      assert_equal result, @searchrecipe.basic_search(1)
    end
  end

  def test_get_full_recipe_data_response 
    VCR.use_cassette('basic_search2', :record => :new_episodes) do
      search_results = @searchrecipe.basic_search(1)
      full_recipes = @searchrecipe.get_full_recipe_data(search_results) #@searchrecipe.get_full_recipe_data(search_results)
      passed_data = @searchrecipe.format_recipe_data(full_recipes)
      assert_equal Array, passed_data.first[:basic_ingredients]
    end
  end

  def test_get_attributes
    skip
    VCR.use_cassette('small_basic_search', :record => :new_episodes) do
      search_results = @searchrecipe.basic_search(2)
      assert_equal 50, @searchrecipe.get_attributes(search_results)
    end
  end

  def test_allowed_ingredients_formats_correctly
    assert_equal "&allowedIngredient[]=garlic&allowedIngredient[]=cognac", @searchrecipe.allowed_ingredients('garlic', 'cognac')
    assert_equal "&allowedIngredient[]=onion%20soup%20mix&allowedIngredient[]=cognac", @searchrecipe.allowed_ingredients('onion soup mix', 'cognac')
  end

  def test_excluded_ingredients_formats_correctly
    assert_equal "&excludedIngredient[]=garlic&excludedIngredient[]=cognac", @searchrecipe.excluded_ingredients('garlic', 'cognac')
  end

  def test_allergies_formats_correctly
    VCR.use_cassette('generate_allergies') do
      Allergy.generate_allergies
      allergies = @searchrecipe.allergies("gluten")
      assert_equal "&allowedAllergy[]=393^Gluten-Free", allergies
    end
  end

  def test_diets_formats_correctly
    VCR.use_cassette('generate_diets') do
      Diet.generate_diets
      diets = @searchrecipe.diet_restrictions("pescetarian")
      assert_equal "&allowedDiet[]=390^Pescetarian", diets
    end
  end

  def test_allergies_handles_multiple_allergies
    skip
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
    Allergy.destroy_all
    Recipe.destroy_all
    Ingredient.destroy_all
  end

end
