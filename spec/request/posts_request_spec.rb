require 'rails_helper'

RSpec.describe 'Post', type: :request do
  context 'Posts/index' do
    current_user = {
      id: 1, name: 'Franklyn', photo: 'https://images.unsplash.com/photo-1651517824434-6765ef914960?ixlib',
      bio: 'He schooled in campain high school', posts_counter: 4, email: 'hello@gmail.com',
      email_confirmed: true, confirm_token: 'jdhdjdhz7zh', role: ' '
    }

    # before(:example) { get users_path }
    before(:example) { get '/users/1/posts' }

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
    before(:example) { get '/users/1/posts/1' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'to render posts/show' do
      expect(response).to render_template('posts/show')
    end

    it 'to have placeholder' do
      expect(response.body).to include 'Comments:'
    end
  end
end
