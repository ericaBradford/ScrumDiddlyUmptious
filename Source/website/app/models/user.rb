class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :foods
  has_many :recipes
  has_many :users_favorites
  has_many :recipes, through: :users_favorites
  has_many :users_preferences
  has_many :foods, through: :users_preferences
  has_many :users_ratings
  has_many :recipes, through: :users_ratings

end
