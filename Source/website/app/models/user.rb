class User < ActiveRecord::Base
  
  attr_accessor :password
  before_save :encrypt_password

  has_many :foods
  has_many :recipes
  has_many :users_favorites
  has_many :recipes, through: :users_favorites
  has_many :users_preferences
  has_many :foods, through :users_preferences
  has_many :users_ratings
  has_many :recipes, through: :users_ratings
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :password, length {in: 4...15, too_short: "Must have at least 4 characters", too_long: "Password cannot be more than 15 characters"}
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: :{with:/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/ , message: "Not correct email format"}
  validates_presence_of :userName
  validates_uniqueness_of :userName
  validates :username, length {in: 4...20, too_short: "Must have at least 4 characters", too_long: "User name cannot be more than 20 characters"}
  
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

#redo validations for this
