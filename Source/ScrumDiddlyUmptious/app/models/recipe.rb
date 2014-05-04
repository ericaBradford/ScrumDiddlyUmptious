class Recipe < ActiveRecord::Base

  belongs_to :users

  validates :title, :ingredients, :directions, :cookTime, :costOfIngredients, :id_Users, :picture, presence: true
  validates :title, length: {in: 4..40, message: "must be 4-40 characters long"}
  validates :title, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :directions, length: {in: 25..15000, message: "should be 30-15000 characters long"}
  validates :cookTime, format: {with: /[0-9]+ [a-zA-Z]+[a-zA-Z0-9 ]*/, message: "must be in the form '3 hours' or '3 hours 29 minutes'"}
  validates :costOfIngredients, format: {with: /[0-9]+(\.[0-9][0-9])?/, message: " can only be in the form '39.00'"}
  validates :ingredients, length: {in: 5..1000, message: "need to be longer."}
  validates :id_Users, format: {with: /[0-9]+/, message: "should only be in number form."}

#paperclip stuff
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/


end
