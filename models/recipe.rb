class Recipe < ActiveRecord::Base

  def create_recipe(args)
    self.name = args[:name]
    self.total_time = args[:total_time]
    self.seconds = args[:seconds].to_i
    self.source_url = args[:source_url]
    self.image_url = args[:images][-1]["imageUrlsBySize"].values.first
    self.servings = args[:servings]
    self.yummly_id = args[:yummly_id]
    self.save
  end

end
