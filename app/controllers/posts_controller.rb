class PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new
    post.save
    redirect_to posts_url, notice: "投稿を完了しました"
  end

  def edit
  end

  private

  def task_params
    params.require(:post).permit(:description)
  end

end
