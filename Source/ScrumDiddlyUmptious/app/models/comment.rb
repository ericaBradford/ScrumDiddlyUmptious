class Comment < ActiveRecord::Base
  belongs_to :recipe

  validates :comment, presence: true
end
