class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :foodName
      t.text :description
      t.boolean :isDairyFree
      t.boolean :isEggFree
      t.boolean :isFishFree
      t.boolean :isMeatFree
      t.boolean :isShellfishFree
      t.boolean :isGlutenFree
      t.boolean :isHighFiber
      t.boolean :isSugarFree
      t.boolean :isPeanutFree
      t.boolean :isTreeNutFree
      t.boolean :isWheatFree
      t.boolean :isSoyFree

      t.timestamps
    end
  end
end
