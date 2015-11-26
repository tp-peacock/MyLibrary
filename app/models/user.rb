class User < ActiveRecord::Base

	  before_save { self.email = email.downcase }
	  validates :name, presence: true, length: { maximum: 30 }
	  validates :email, presence: true, length: { maximum: 60 }, uniqueness: { case_sensitive: false }
	  has_secure_password
	  validates :password, presence: true, length: { minimum: 6 }
end
