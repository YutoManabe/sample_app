class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase) # find_byは『ユーザー情報』か『nil』を返す
		if user && user.authenticate(params[:session][:password]) # 認証が成功した場合
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
    	sign_out
    	redirect_to root_url
	end
end
