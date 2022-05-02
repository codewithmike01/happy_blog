class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  # A method that returns the 3 most recent posts for a given user.
  def three_recent_post(user_id)
    Post.order(updated_at: :desc).where(user_id: user_id).first(3)
  end
end
