class ChangeCookTimeInRecipes < ActiveRecord::Migration
  def up
    change_column :recipes, :cookTime, :string, :limit => 32
  end

  def down
    change_column :recipes, :cookTime, :decimal
  end
end
