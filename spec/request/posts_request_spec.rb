require 'rails_helper'

RSpec.describe 'Post', type: :request do
  context 'Posts/index' do
    # before(:example) { get users_path }
    before(:example) { get '/users/:id/posts' }
    it 'is sucess' do
      expect(response).to have_http_status(:ok)
    end

    it 'to render posts/imdex' do
      expect(response).to render_template('posts/index')
    end

    it 'to have placeholder' do
      expect(response.body).to include 'Here is a list of posts for a given user'
    end
  end

  context 'Posts/show' do
    before(:example) { get '/users/:id/posts/;id' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'to render posts/show' do
      expect(response).to render_template('posts/show')
    end

    it 'to have placeholder' do
      expect(response.body).to include 'Here is a post for a given user'
    end
  end
end
