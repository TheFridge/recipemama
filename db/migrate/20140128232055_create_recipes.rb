class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :total_time
      t.integer :seconds
      t.string :source_url
      t.string :servings
      t.string :image_url
      t.string :yummly_id
      t.string :ingredient_list, default: [], array: true
    end
  end
end
