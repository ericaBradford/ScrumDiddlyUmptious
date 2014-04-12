class CreateRecipesIngredients < ActiveRecord::Migration
  def change
    create_table :recipes_ingredients do |t|
      t.integer :id_Recipes
      t.integer :id_Foods

      t.timestamps
    end
  end
end
