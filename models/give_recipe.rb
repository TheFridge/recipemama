class GiveRecipe

  def self.generate_random
    offset = rand(Recipe.count)
    rand_record = Recipe.first(:offset => offset)
  end

end
