require 'test_helper'

class GiveRecipeTest < Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def test_it_provides_random_recipe
    Recipe.create
    Recipe.create
    assert_equal Recipe, GiveRecipe.generate_random.class
  end

end
