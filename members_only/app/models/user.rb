class User < ApplicationRecord

  before_save :downcase_email
  before_create :remember

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
  has_many :posts

  # forgets a user
  def forget
  	update_attribute(:remember_token, nil)
  end

  private

    # remembers a user in the database for use in presistent sessions.
    def remember
      self.remember_token = User.digest(User.new_token)
    end

  	# returns a random token
  	def User.new_token
  		SecureRandom.urlsafe_base64
  	end 
  	
  	# returns the hash digest of the given string
		def User.digest(string)
    	Digest::SHA1.hexdigest(string.to_s)
  	end

	  # converts email to downcase
	  def downcase_email
	  	email.downcase!
	  end
end
