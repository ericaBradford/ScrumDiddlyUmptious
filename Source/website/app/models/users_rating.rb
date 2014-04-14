class UsersRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  validates_associated :user, :recipe
  validates :rating, presence: true
  validates :rating, format: {with: [1-5], message: "rating can only be 1-5"}
end
