class Api::V1::CommentsController < ApplicationController
  def index
    @comments = Comment.includes(:post).includes(:user).where(user_id: params[:user_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(
      text: allowed_params[:text],
      user_id: current_user.id,
      post_id: @post.id
    )
    if @comment.save
      Comment.comment_count(params[:post_id])
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Successfully created comment'
    else
      redirect_to user_posts_path(params[:user_id])
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    Comment.comment_count(params[:post_id])
    redirect_to user_post_path(params[:user_id], params[:post_id]), alert: 'Successfully deleted comment'
  end

  private

  def allowed_params
    params.require(:comment).permit(:text)
  end
end
