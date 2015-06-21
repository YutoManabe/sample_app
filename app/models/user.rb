class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy

	# メールアドレスのフォーマット
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	# メールアドレスを小文字へ変換する
	before_save { self.email = email.downcase }

	# 保存前にremember_tokenを作成(signup)
	before_create :create_remember_token

	# DBには保存しないが、一時的にのみ保存可能になる
	has_secure_password

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	# remember_tokenを作成
	def User.new_remember_token
    	SecureRandom.urlsafe_base64
	end

	# remember_tokenを暗号化
	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s) # nilによるテストエラーをto_sで回避
	end

	def feed
		Micropost.where("user_id = ?", id)
	end

	private
		# 暗号化したremember_tokenをDBに保存
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
