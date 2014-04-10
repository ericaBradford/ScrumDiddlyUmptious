class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.decimal :cookTime
      t.decimal :costOfIngredients
      t.binary :canPrepareAhead

      t.timestamps
    end
  end
end
