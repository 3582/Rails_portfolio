require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Registrations', :type => :request do
  describe '/api/v1/auth' do
    before do
      user = { :email => 'hoge@test.com', :password => '12345678', :password_confirmation => '12345678' }
      sign_up(user)
    end
    it 'ユーザー登録できること' do
      json = JSON.parse(response.body)
      expect(json['status']).to eq('success')
      expect(json['data']['id']).to eq(User.last.id)
      expect(json['data']['email']).to eq(User.last.email)
      expect(response).to have_http_status(200)
    end
    it 'ログインできること' do
      user_in = { :email => 'hoge@test.com', :password => '12345678' }
      sign_in(user_in)
      json = JSON.parse(response.body)
      expect(response.headers['uid']).to be_present
      expect(response.headers['access-token']).to be_present
      expect(response.headers['client']).to be_present
      expect(response).to have_http_status(200)
    end
  end
end
