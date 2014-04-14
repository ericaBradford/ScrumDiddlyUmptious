class RecipesIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :food

  validates_associated :recipe, :food
end
