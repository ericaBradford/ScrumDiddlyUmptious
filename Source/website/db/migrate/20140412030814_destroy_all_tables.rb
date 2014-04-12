class DestroyAllTables < ActiveRecord::Migration
  def up
    drop_table :users
    drop_table :foods
    drop_table :recipes
    drop_table :recipes_ingredients
    drop_table :users_favorites
    drop_table :users_preferences
    drop_table :users_ratings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
