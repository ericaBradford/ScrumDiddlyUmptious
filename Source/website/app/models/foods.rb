class Foods < ActiveRecord::Base
  has_many :recipes_ingredients
  has_many :recipes, through: :recipes_ingredients
  has_many :users_preferences
  has_many :users, through: :users_preferences

  validates :foodName, presence: true, format{with: /^[A-Za-z ]+$/, message: "Title can only has alphabetical characters and spaces"}, length: {in: 4..40, message: "Name of the food must be 4-40 characters long"}, uniqueness: {case_sensitive: false, message: "There is already a food with that name"}
  validates :description, presence: true, length: {in: 30..3000, message: "Description should be 30-3000 characters long"}
end
