class RecipesIngredients < ActiveRecord::Base
  belongs_to :recipes
  belongs_to :foods

  validates_associated :recipes, :food
end
