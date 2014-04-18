class Food < ActiveRecord::Base
  has_many :recipes_ingredients
  has_many :recipes, through: :recipes_ingredients
  has_many :users_preferences
  has_many :users, through: :users_preferences

  before_save :fix_id

  accepts_nested_attributes_for :recipes

  validates :foodName, :description, presence: true 
  validates :foodName, format: {with: /\A([a-zA-Z]+\s)*[a-zA-Z]+\Z/, message: "Title can only has alphabetical characters and spaces"}
  validates :foodName, length: {in: 4..40, message: "Name of the food must be 4-40 characters long"}
  validates :foodName, uniqueness: {case_sensitive: false, message: "There is already a food with that name"}
  validates :description, length: {in: 11..3000, message: "Description should be 30-3000 characters long"}

  def fix_id
    self.id_Users.to_i
  end
end
