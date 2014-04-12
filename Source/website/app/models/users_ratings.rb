class UsersRatings < ActiveRecord::Base
  belongs_to :users
  belongs_to :recipes

  validates_associated :users, :recipes
  validates :rating, presence: true, format{with: [1-5], message: "rating can only be 1-5"}
end
