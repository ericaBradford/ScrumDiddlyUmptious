class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :foodName
      t.text :description
      t.integer :id_Users
      t.binary :isDairyFree
      t.binary :isEggFree
      t.binary :isFishFree
      t.binary :isMeatFree
      t.binary :isShellfishFree
      t.binary :isGlutenFree
      t.binary :isHighFiber
      t.binary :isSugarFree
      t.binary :isPeanutFree
      t.binary :isTreenutFree
      t.binary :isWheatFree
      t.binary :isSoyFree

      t.timestamps
    end
  end
end
