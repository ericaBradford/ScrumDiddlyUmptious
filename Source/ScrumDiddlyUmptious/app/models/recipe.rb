class Recipe < ActiveRecord::Base
  belongs_to :users

  validates :title, :ingredients, :directions, :cookTime, :costOfIngredients, :id_Users, presence: true
  validates :title, length: {in: 4..40, message: "Title must be 4-40 characters long"}
  validates :title, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :directions, length: {in: 25..15000, message: "Directions should be 30-15000 characters long"}
  validates :cookTime, format: {with: /[0-9]+ [a-zA-Z]+[a-zA-Z0-9 ]*/, message: "Cook time must be in the form '3 hours' or '3 hours 29 minutes'"}
  validates :costOfIngredients, format: {with: /[0-9]+(\.[0-9][0-9])?/, message: "Cost of ingredients can only be in the form '39.00'"}
  validates :ingredients, length: {in: 5..1000, message: "You should input 5-1000 characters for your ingredients list. Don't forget amounts for each ingredients."}
  validates :id_Users, format: {with: /[0-9]+/, message: "Nice try. User ids can only be numbers."}


end