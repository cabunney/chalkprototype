class User < ActiveRecord::Base
	has_many	:questions
	has_many	:answers
	
	attr_accessible :username, :email, :school_name, :first_name, :last_name, 
	  :password, :password_confirmation
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
 
  validates :username, presence: true, length: { maximum: 50 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :school_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 },:confirmation => true
  validates :password_confirmation, presence: true
  
  acts_as_voter
  
  private
     def create_remember_token
       self.remember_token = SecureRandom.urlsafe_base64
     end
end
