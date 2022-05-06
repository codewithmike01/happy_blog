require 'rails_helper'

RSpec.describe 'Post', type: :request do
  context 'Posts/index' do
    # before(:example) { get users_path }
    before(:example) { get '/users/148/posts' }
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
    before(:example) { get '/users/148/posts/1' }
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
