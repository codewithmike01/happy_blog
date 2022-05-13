require 'rails_helper'

RSpec.describe 'Post', type: :request do
  context 'Posts/index' do
    # before(:example) { get users_path }

    before(:example) do
      user = User.create!(name: 'JPoster', email: 'jPostlinks@gmail.com', confirmed_at: Time.now, password: 'password',
                          password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

      get user_posts_path(user.id)
    end

    it 'is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'to render posts/index' do
      expect(response).to render_template('posts/index')
    end

    it 'to have placeholder' do
      expect(response.body).to include 'Number of posts'
    end
  end

  context 'Posts/show' do
    before(:example) do
      user = User.create!(name: 'God', email: 'Helpss@gmail.com', confirmed_at: Time.now, password: 'password',
                          password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
      post = Post.create!(title: 'Price', text: 'Price life alright', comments_counter: 4, likes_counter: 9,
                          user_id: user.id)
      get user_post_path(user.id, post.id)
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'to render posts/show' do
      expect(response).to render_template('posts/show')
    end

    it 'to have placeholder' do
      expect(response.body).to include 'Comments: 4'
    end
  end
end
