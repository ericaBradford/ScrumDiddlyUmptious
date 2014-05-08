class Recipe < ActiveRecord::Base

#associations
  belongs_to :user
  has_many :comments

  has_many :favorite_recipes
  has_many :users, through: :favorite_recipes, source: :user

#validations
  validates :title, :ingredients, :directions, :cookTime, :costOfIngredients, :id_Users, :description, :picture, presence: true
  validates :title, length: {in: 4..40, message: "must be 4-100 characters long"}
  validates :title, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :description, length: {in: 10..300, message: "must be 10-300 characters long"}
  validates :description, format: {with: /[0-9A-Za-z.!?,:]+/, message: "may only consist of letters, numbers, and basic punctuation."}
  validates :directions, length: {in: 25..15000, message: "should be 30-15000 characters long"}
  validates :cookTime, format: {with: /[0-9]+ [a-zA-Z]+[a-zA-Z0-9 ]*/, message: "must be in the form '3 hours' or '3 hrs 29 minutes'"}
  validates :costOfIngredients, format: {with: /[+-]?[0-9]{1,3}(?:,?[0-9]{3})*(?:\.[0-9]{2})?/, message: " can only be in the form '39.00'"}
  validates :ingredients, length: {in: 5..1000, message: "need to be longer."}
  validates :id_Users, format: {with: /[0-9]+/, message: "should only be in number form."}

#paperclip stuff
  has_attached_file :picture, :styles => { :medium => "400x400>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

#letsrate
  
letsrate_rateable "Rating"

end
