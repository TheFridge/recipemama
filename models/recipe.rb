class Recipe < ActiveRecord::Base
  has_many :ingredients

  def create_recipe(args)
    self.name = args[:name]
    self.total_time = args[:total_time]#.slice(0..100)
    self.seconds = args[:seconds].to_i
    self.source_url = args[:source_url]
    self.image_url = args[:images][-1]["imageUrlsBySize"].values.last if args[:images]
    self.servings = args[:servings]
    self.yummly_id = args[:yummly_id]
    self.ingredient_list = []
    self.save
    if args[:ingredients]
      args[:ingredients].each do |list_item|
        i = Ingredient.new
        i.description = list_item#.slice(0..100)
        i.recipe_id = self.id
        i.save
      end
    end
  end

end
