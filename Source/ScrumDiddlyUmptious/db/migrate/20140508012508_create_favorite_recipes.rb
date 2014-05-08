class CreateFavoriteRecipes < ActiveRecord::Migration
  def change
    create_table :favorite_recipes do |t|
      t.integer :id_Recipes
      t.integer :id_Users

      t.timestamps
    end
  end
end



