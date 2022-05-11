require 'rails_helper'

RSpec.describe 'Post model', type: :model do
  subject do
    Post.new(title: 'Real stressed', text: 'Price i have to pay working late', comments_counter: 4, likes_counter: 9,
             user_id: 1)
  end
  before { subject.save }

  it 'Name should not be nul' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Title length not more than 250' do
    subject.title = 'a' * 300
    expect(subject).to be_invalid
  end

  it 'Comments counter Numericality greater than 0' do
    subject.comments_counter = -1
    expect(subject).to be_invalid
  end

  it 'Likes counter Numericality greater than 0' do
    subject.likes_counter = -2
    expect(subject).to be_invalid
  end

  it 'Test update_counter method ' do
    posts = Post.update_counter(subject.user_id)
    expect(posts).to be_truthy
  end

  it 'Test  five_recent_comment method ' do
    comments = subject.five_recent_comment(subject.user_id)
    expect(comments.length).to eq(1)
  end
end
