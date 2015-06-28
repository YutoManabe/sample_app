class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # redirect_to @user
    respond_to do |format| # respond_to: 拡張子（フォーマット）毎に振る舞いを変える
      format.html { redirect_to @user }
      format.js # => create.js.erb
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # redirect_to @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # => destroy.js.erb
    end
  end
end