class CreateUsersPreferences < ActiveRecord::Migration
  def change
    create_table :users_preferences do |t|

      t.integer :id_Users

      t.binary :isVegan
      t.binary :isVegetarian
      t.binary :isPescatarian
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


      t.timestamps
    end
  end
end
