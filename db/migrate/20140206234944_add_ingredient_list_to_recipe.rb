class AddIngredientListToRecipe < ActiveRecord::Migration
  def change
    remove_column :recipes, :ingredient_list
    add_column :recipes, :ingredient_list, :string, array: true, default: '{}'
  end
end
