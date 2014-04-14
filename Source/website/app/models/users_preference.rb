class UsersPreference < ActiveRecord::Base
  belongs_to :food
  belongs_to :user

  validates_associated :food, :user
end
