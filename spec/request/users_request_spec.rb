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
      expect(response.body).to include 'Number of posts'
    end
  end

  context 'User/show' do
    current_user = User.new(
      name: 'Franklyn', photo: 'https://images.unsplash.com/photo-1651517824434-6765ef914960?ixlib',
      bio: 'He schooled in campain high school', posts_counter: 4, email: 'hello@gmail.com',
      email_confirmed: true, confirm_token: 'jdhdjdhz7zh'
    )
    current_user.save
    before(:example) { get "/users/#{current_user.id}" } # get(:user#show)

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'render user/show template' do
      expect(response).to render_template('users/index')
    end

    it 'has placeholder' do
      expect(response.body).to include 'Number of posts'
    end
  end
end
