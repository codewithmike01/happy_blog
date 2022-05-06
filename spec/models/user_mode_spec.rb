require 'rails_helper'

RSpec.describe 'User model', type: :model do
  subject { User.new(name: 'Franklyn', photo: 'https://images.unsplash.com/photo-1651517824434-6765ef914960?ixlib', bio: 'He schooled in campain high school', posts_counter: 4) }
  before { subject.save }

  it 'Name should not be nul' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Posts counterNumericality greater than 0' do
    subject.posts_counter = -1
    expect(subject).to be_invalid
  end

  it 'Test three_recent_post method ' do
    posts = subject.three_recent_post(subject.id)
    expect(posts.length).to eq(0)
  end
end
