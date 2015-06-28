class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy # relationshipsテーブルのどのidと紐付けするか(外部キー)。foreign_keyを使えば、_idというレールから外れることができる。ユーザーが削除されたらrelationshipsの情報も削除してしまう。
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy # reverse_relationshipクラスを探しに行かないように。
	has_many :followed_users, through: :relationships, source: :followed # idの集合に対して、それぞれにfollowedメソッドを実行してください。（mapメソッドと同様の機能）
	# has_manyの本来の使い方：作りたいメソッド名を先に置く。便利メソッドを作るためのものである。

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
		# Micropost.where("user_id = ?", id)
		Micropost.from_users_followed_by(self)
	end

	# フォロー済みであれば、ユーザー情報を得る
	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	# フォロー機能
	def follow!(other_user)
		self.relationships.create!(followed_id: other_user.id)
	end

	# アンフォロー機能
	def unfollow!(other_user)
    	relationships.find_by(followed_id: other_user.id).destroy
  	end

	private
		# 暗号化したremember_tokenをDBに保存
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
