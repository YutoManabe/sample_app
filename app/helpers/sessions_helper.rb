module SessionsHelper

	# ゲッター
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	# セッター
	def current_user=(user)
    	@current_user = user
	end

	def current_user?(user)
	    user == current_user
	end

	# ログイン
	def sign_in(user)
		remember_token = User.new_remember_token # 認証に成功したら、新たにremember_tokenを作成
		cookies.permanent[:remember_token] = remember_token # remember_tokenをブラウザのクッキーに永続的に保存する
		user.update_attribute(:remember_token, User.encrypt(remember_token)) # DBを更新する
		self.current_user = user # セッターが呼び出される
	end

	# ログイン済？
	def signed_in?
    	!current_user.nil?
	end

	# ログアウト
	def sign_out
    	self.current_user = nil
    	cookies.delete(:remember_token)
	end

	# フレンドリーフォワーディング
	def redirect_back_or(default)
	    redirect_to(session[:return_to] || default)
	    session.delete(:return_to)
	end

	# 行きたかった場所を一時的に保存する
	def store_location
	    session[:return_to] = request.url
	end

	# サインインしているかどうかのチェック
    def signed_in_user
    	store_location # 行きたかった場所の情報をこっそり保存
    	redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
