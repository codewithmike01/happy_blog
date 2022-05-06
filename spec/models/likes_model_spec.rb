require 'rails_helper'

RSpec.describe 'Like model', type: :model do
  subject { Like.new(post_id: 1, user_id: 148) }
  before { subject.save }

  it 'Test  like_count method ' do
    like = subject.like_count(subject.post_id)
    expect(like).to be_truthy
  end
end
