class User < ActiveRecord::Base

  has_many :books, dependent: :destroy
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 30 }
	validates :email, presence: true, length: { maximum: 60 }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  mount_uploader :picture, PictureUploader
  validate :picture_size

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

 private

    def picture_size
      if picture.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
      end
    end

end
