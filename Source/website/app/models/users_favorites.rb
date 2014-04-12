class UsersFavorites < ActiveRecord::Base
  belongs_to :users
  belongs_to :recipes

  validates_associated :users, :recipes
end
