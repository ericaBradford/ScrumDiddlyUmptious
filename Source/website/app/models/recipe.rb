class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipes_ingredients
  has_many :foods, through: :recipes_ingredients
  has_many :users_ratings
  has_many :users, through: :users_ratings
  has_many :users_favorites
  has_many :users, through: :users_favorites

  accepts_nested_attributes_for :foods

  validates_associated :food

  validates :title, :directions, :cookTime, :costOfIngredients, presence: true
  validates :title, length: {in: 4..40, message: "Title must be 4-40 characters long"}
  validates :title, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :directions, length: {in: 30..15000, message: "Directions should be 30-15000 characters long"}
  VALID_NUMBER_REGEX = /[0-9]{1,3}(?:,?[0-9]{3})*(?:\.[0-9]{2})?/
  validates :cookTime, format: {with: VALID_NUMBER_REGEX, message: "Cook time can only be a number or a decimal"}
  validates :costOfIngredients, format: {with: VALID_NUMBER_REGEX, message: "Cost of ingredients can only be in the form '39.00'"}
end

# validate that ingredients are entered
