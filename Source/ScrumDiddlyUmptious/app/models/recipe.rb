class Recipe < ActiveRecord::Base

  has_many :foods

  validates_associated :foods

  validates :title, :directions, :cookTime, :costOfIngredients, presence: true
  validates :title, length: {in: 4..40, message: "Title must be 4-40 characters long"}
  validates :title, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :directions, length: {in: 30..15000, message: "Directions should be 30-15000 characters long"}
  validates :cookTime, format: {with: /([01]?[0-9]|2[0-3]):[0-5][0-9]/, message: "Cook time can only be a number or a decimal"}
  validates :costOfIngredients, format: {with: /[0-9]+\.[0-9][0-9](?:[^0-9]|$)/, message: "Cost of ingredients can only be in the form '39.00'"}

end
