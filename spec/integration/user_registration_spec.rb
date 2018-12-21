require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let!(:user) { build(:user) }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      parsed = JSON.parse(response.body)
      expect(parsed['email']).to eq user.email
    end
  end

  context 'when user already exists' do
    # create this user in the database already
    let!(:second_user) { create(:user) }
    let(:params) do
      {
        user: {
          email: second_user.email,
          password: second_user.password
        }
      }
    end

    before do      
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      parsed = JSON.parse(response.body)
      expect(parsed['errors'].first['title']).to eq('Bad Request')
    end
  end
end