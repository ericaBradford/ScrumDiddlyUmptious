class UsersFavorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  validates_associated :user, :recipe
end
