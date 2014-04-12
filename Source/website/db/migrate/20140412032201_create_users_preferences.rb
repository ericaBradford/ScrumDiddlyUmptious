class CreateUsersPreferences < ActiveRecord::Migration
  def change
    create_table :users_preferences do |t|
      t.integer :id_Foods
      t.integer :id_Users

      t.timestamps
    end
  end
end
