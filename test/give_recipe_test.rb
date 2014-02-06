require_relative './test_helper'

class GiveRecipeTest < Minitest::Unit::TestCase
  def setup
  end

  def test_it_provides_random_recipe
    Recipe.create
    Recipe.create
    assert_equal Recipe, GiveRecipe.generate_random.class
  end

  def test_it_provides_a_recipe_based_on_id
  end

  def teardown
    Allergy.destroy_all
    Recipe.destroy_all
    Ingredient.destroy_all
  end

end
