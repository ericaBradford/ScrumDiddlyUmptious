class Users < ActiveRecord::Base
  has_many :users_ratings
  has_many :recipes, through: :users_ratings
  has_many :users_preferences
  has_many :foods, through: :users_preferences
  has_many :users_favorites
  has_many :recipes, through: :users_favorites

  validates :userName, presence: true, length: {in: 5..15, message: "User name must be 5-15 characters long"}, uniqueness: {case_sensitive: false, message: "There is already a user with that name"}
  validates :email, presence: true, format{ with: \b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b, message: "Not a valid email"}, length: {in: 13..35, message: "Email must be 13-35 characters long"}, uniqueness: {case_sensitive: false, message: "There is already a user using  that email"}
  validates :password, presence: true, confirmation: true, length: {in: 5..20, message: "Password must be 5-20 characters long"}
  validates :password_confirmation, presence: true
end
