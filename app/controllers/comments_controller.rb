class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(
      text: allowed_params[:text],
      user_id: current_user.id,
      post_id: @post.id
    )
    if @comment.save
      @comment.comment_count(params[:post_id])
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      redirect_to user_posts_path(params[:user_id])
    end
  end

  private

  def allowed_params
    params.require(:comment).permit(:text)
  end
end
