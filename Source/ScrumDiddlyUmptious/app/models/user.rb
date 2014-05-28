class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :preferences

  letsrate_rater

  has_many :recipes

  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes

  has_attached_file :profilePic, styles => { :medium => "300x300>", :thumb => "75x75>"}
end
