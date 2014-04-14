class User < ActiveRecord::Base
  has_many :users_rating
  has_many :recipe, through: :users_rating
  has_many :users_preference
  has_many :food, through: :users_preference
  has_many :users_favorite
  has_many :recipe, through: :users_favorite

  validates :userName, :email, :password, :password_confirmation, presence: true
  validates :userName, length: {in: 5..15, message: "User name must be 5-15 characters long"} 
  validates :userName, uniqueness: {case_sensitive: false, message: "There is already a user with that name"}
  validates :email, format: { with: \b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b, message: "Not a valid email"}
  validates :email, length: {in: 13..35, message: "Email must be 13-35 characters long"}
  validates :email, uniqueness: {case_sensitive: false, message: "There is already a user using  that email"}
  validates :password, confirmation: true
  validates :password, length: {in: 5..20, message: "Password must be 5-20 characters long"}
end
