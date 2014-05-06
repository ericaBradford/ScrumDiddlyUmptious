json.array!(@preferences) do |preference|
  json.extract! preference, :id, :isPescatarian, :isVegetarian, :isVegan, :isDiabetic, :isAllergicGluten, :isAllergicPeanuts, :isAllergicTreenuts, :isAllergicDairy, :isAllergicEggs, :isAllergicWheat, :isAllergicSoy, :isAllergicFish, :isAllergicShellfish, :isAsianVegetarian, :isHindu, :isMuslim, :isJain, :isKosher, :foodsToFilter, :user_id
  json.url preference_url(preference, format: :json)
end
