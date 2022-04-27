require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'User/index' do
    before(:example) { get users_path } # get(:users#index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('users/index')
    end

    it 'has placeholder' do
      expect(response.body).to include 'Here is a list users'
    end
  end

  context 'User/show' do
    before(:example) { get '/users/:id' } # get(:user#show)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'render user/show template' do
      expect(response).to render_template('users/show')
    end

    it 'has placeholder' do
      expect(response.body).to include 'Here is a user'
    end
  end
end
