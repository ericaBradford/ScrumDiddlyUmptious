class Recipes < ActiveRecord::Base
  belongs_to :users
  has_many :recipes_ingredients
  has_many :foods, through: :recipes_ingredients
  has_many :users_ratings
  has_many :users, through: :users_ratings
  has_many :users_favorites
  has_many :users, through: :users_favorites

  validates_associated :foods

  validates :title, presence: true, length: {in: 4..40, message: "Title must be 4-40 characters long"}, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :directions, presence: true, length: {in: 30..15000, message: "Directions should be 30-15000 characters long"}
  validates :cookTime, presence: true, format{with: [0-9]+(\.[0-9][0-9]?)?, message: "Cook time can only be a number or a decimal"}
  validates :costOfIngredients, presence: true, format{with: ^\d+(.\d{1,2})?$, message: "Cost of ingredients can only be in the form '39.00'"}
end

# validate that ingredients are entered
