class CreateDiet < ActiveRecord::Migration
  def change
    create_table :diets do |t|
      t.string :yummly_id
      t.string :name
      t.string :yummly_code
    end
  end
end
