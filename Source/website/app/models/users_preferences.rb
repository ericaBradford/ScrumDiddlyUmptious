class UsersPreferences < ActiveRecord::Base
  belongs_to :foods
  belongs_to :users

  validates_associated :foods, :users
end
