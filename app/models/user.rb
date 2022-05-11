# rubocop:disable Naming/ConstantName

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Remember to Validate the user email and password to be present
  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  # Relationship
  has_many :posts
  has_many :likes
  has_many :comments

  # authorization Roles
  Roles = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  # A method that returns the 3 most recent posts for a given user.
  def three_recent_post(user_id)
    Post.order(updated_at: :desc).where(user_id: user_id).first(3)
  end
end
