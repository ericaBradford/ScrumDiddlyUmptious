class User < ActiveRecord::Base
  
  before_save :encrypt_password

  has_many :foods
  has_many :recipes
  has_many :users_favorites
  has_many :recipes, through: :users_favorites
  has_many :users_preferences
#  has_many :foods, through :users_preferences
  has_many :users_ratings
  has_many :recipes, through: :users_ratings
  
#  validates :password, confirmation: true
#  validates :password, :email, :userName, presence: true
#  validates :password, length {in: 4...15, message: "Your password should be 4-15 characters long"}
#  validates :email, uniqueness: {case_sensitive: false, message: "There is already a user with that email"}
#  validates :email, format: {with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/ , message: "Not correct email format"}
#  validates :userName, uniqueness {case_sensitive: false, message: "That user name is taken"}
#  validates :username, length {in: 4...20, message: "Your user name needs to be 4-20 characters long"}
  
  def self.authenticate(userName, password)
    user = find_by_userName(userName)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
