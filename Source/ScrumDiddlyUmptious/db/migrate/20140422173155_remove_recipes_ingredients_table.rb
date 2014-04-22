class RemoveRecipesIngredientsTable < ActiveRecord::Migration
  def change
    drop_table :recipes_ingredients
  end
end
