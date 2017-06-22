class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	has_secure_password
	has_many :parts
	has_many :user_manufacturers
	has_many :manufacturers, through: :user_manufacturers

end