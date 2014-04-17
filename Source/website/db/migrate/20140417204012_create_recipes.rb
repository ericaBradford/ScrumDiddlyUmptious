class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :directions
      t.decimal :cookTime, precision: 4, scale: 2
      t.decimal :costOfIngredients, precision: 6, scale: 2
      t.binary :canPrepareAhead
      t.integer :id_Users

      t.timestamps
    end
  end
end
