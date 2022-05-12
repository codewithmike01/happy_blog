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
      expect(response.body).to include('Home')
    end
  end

  context 'User/show' do
    before(:example) do
      user = User.create!(name: 'Novice', email: 'Novicenks@gmail.com', confirmed_at: Time.now, password: 'password',
                          password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

      get user_path(user.id)
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'render user/show template' do
      expect(response).to render_template('users/show')
    end

    it 'has placeholder' do
      expect(response.body).to include('Novice')
    end
  end
end
