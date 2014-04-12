class CreateUsersFavorites < ActiveRecord::Migration
  def change
    create_table :users_favorites do |t|
      t.integer :id_Users
      t.integer :id_Recipes

      t.timestamps
    end
  end
end
