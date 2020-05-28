class UsersController < ApplicationController

  def index
    @q = User.all.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(9)
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
    redirect_to user_path, notice: "#{user.name}さんのプロフィールを更新しました"
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    #@users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    #@users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :avatar)
  end

end
