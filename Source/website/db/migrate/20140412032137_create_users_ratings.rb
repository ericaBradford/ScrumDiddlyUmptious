class CreateUsersRatings < ActiveRecord::Migration
  def change
    create_table :users_ratings do |t|
      t.integer :id_Users
      t.integer :id_Recipes
      t.integer :rating

      t.timestamps
    end
  end
end
