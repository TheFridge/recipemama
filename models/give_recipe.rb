class GiveRecipe

  def self.generate_random
    offset = rand(Recipe.count)
    rand_record = Recipe.first(:offset => offset)
  end

  def self.generate_from_id(id)
    Recipe.find(id)
  end

end
