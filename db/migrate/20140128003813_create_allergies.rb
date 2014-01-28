class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :yummly_id
      t.string :name
      t.string :yummly_code
    end
  end
end
