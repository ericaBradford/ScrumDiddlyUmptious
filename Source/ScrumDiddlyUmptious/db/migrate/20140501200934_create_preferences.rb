class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :id_Users
      t.string :foodsToFilter
      t.boolean :isPescatarian
      t.boolean :isVegetarian
      t.boolean :isVegan
      t.boolean :isDiabetic
      t.boolean :noAlcohol
      t.boolean :isAllergicGluten
      t.boolean :isAllergicPeanuts
      t.boolean :isAllergicTreenuts
      t.boolean :isAllergicDairy
      t.boolean :isAllergicEggs
      t.boolean :isAllergicWheat
      t.boolean :isAllergicSoy
      t.boolean :isAllergicFish
      t.boolean :isAllergicShellfish
      t.boolean :isAsianVegetarian
      t.boolean :isHindu
      t.boolean :isMuslim
      t.boolean :isJain
      t.boolean :isKosher
    end
  end
end
