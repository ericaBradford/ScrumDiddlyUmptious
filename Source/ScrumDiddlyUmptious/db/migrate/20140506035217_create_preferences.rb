class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :id_Users
      t.string :blacklistFoods, default: ""
      t.boolean :isPescatarian, default: false
      t.boolean :isVegetarian, default: false
      t.boolean :isVegan, default: false
      t.boolean :isDiabetic, default: false
      t.boolean :noAlcohol, default: false
      t.boolean :isAllergicGluten, default: false
      t.boolean :isAllergicPeanuts, default: false
      t.boolean :isAllergicTreenuts, default: false
      t.boolean :isAllergicDairy, default: false
      t.boolean :isAllergicEggs, default: false
      t.boolean :isAllergicWheat, default: false
      t.boolean :isAllergicSoy, default: false
      t.boolean :isAllergicFish, default: false
      t.boolean :isAllergicShellfish, default: false
      t.boolean :isAsianVegetarian, default: false
      t.boolean :isHindu, default: false
      t.boolean :isMuslim, default: false
      t.boolean :isJain, default: false
      t.boolean :isKosher, default: false
    end
  end
end
