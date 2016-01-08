class User < ActiveRecord::Base

  has_many :books, dependent: :destroy

	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 30 }
	validates :email, presence: true, length: { maximum: 60 }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
