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
    @post = Post.new(
      title: allowed_params[:title],
      text: allowed_params[:text],
      comments_counter: 0,
      likes_counter: 0,
      user_id: params[:user_id]
    )

    if @post.save
      @post.update_counter(params[:user_id])
      redirect_to user_posts_path(params[:user_id]), success: 'Successfully created a post'
    else
      flash.now[:error] = 'Post was not created'
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:post).permit(:title, :text)
  end
end
