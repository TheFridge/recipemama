class Recipe < ActiveRecord::Base
    has_many :ingredients

  def create_recipe(args)
    self.name = args[:name]
    self.total_time = args[:total_time]
    self.seconds = args[:seconds].to_i
    self.source_url = args[:source_url]
    self.image_url = args[:images][-1]["imageUrlsBySize"].values.last
    self.servings = args[:servings]
    self.yummly_id = args[:yummly_id]
    self.ingredient_list = args[:basic_ingredients].join("/")
    self.save
    args[:ingredients].each do |list_item|
      i = Ingredient.new
      i.description = list_item
      i.recipe_id = self.id
      i.save
    end
  end

end
