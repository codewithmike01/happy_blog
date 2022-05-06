#  class Post Controller
class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).where(user_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(allowed_params)
    if @post.save
      @post.update_counter(params[:user_id])
      redirect_to user_posts_path(@user.id)
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:post).permit(:title, :text, :user_id)
  end
end
