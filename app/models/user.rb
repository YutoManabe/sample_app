class User < ActiveRecord::Base

	# メールアドレスのフォーマット
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	# DB保存前に小文字へ変換する
	before_save { self.email = email.downcase! }

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	has_secure_password
	validates :password, length: { minimum: 6 }
end
