class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.binary :isPescatarian
      t.binary :isVegetarian
      t.binary :isVegan
      t.binary :isDiabetic
      t.binary :isAllergicGluten
      t.binary :isAllergicPeanuts
      t.binary :isAllergicTreenuts
      t.binary :isAllergicDairy
      t.binary :isAllergicEggs
      t.binary :isAllergicWheat
      t.binary :isAllergicSoy
      t.binary :isAllergicFish
      t.binary :isAllergicShellfish
      t.binary :isAsianVegetarian
      t.binary :isHindu
      t.binary :isMuslim
      t.binary :isJain
      t.binary :isKosher
      t.string :foodsToFilter
      t.references :user, index: true

      t.timestamps
    end
  end
end
