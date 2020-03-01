class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update!(user_params)
    redirect_to user_path, notice: "#{user.username}さんのプロフィールを更新しました"
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :introduction, :avatar)
  end

end
