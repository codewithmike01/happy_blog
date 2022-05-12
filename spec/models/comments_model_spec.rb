require 'rails_helper'

RSpec.describe 'Comment model', type: :model do
  subject do
    num = Random.rand(1...1000)
    user = User.create!(name: "Jony#{num}", email: "john105#{num}@gmail.com", confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
    post = Post.create!(title: 'mike', text: 'mike', likes_counter: 3, comments_counter: 3, user_id: user.id)
    Comment.new(text: 'This is Gods work', post_id: post.id, user_id: user.id)
  end
  before { subject.save }

  it 'Test comment_count method ' do
    comment = Comment.comment_count(subject.post_id)
    expect(comment).to be_truthy
  end
end
