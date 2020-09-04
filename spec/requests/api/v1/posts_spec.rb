require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe '/api/v1/posts' do
    it '10取得できるかの確認 index' do
      FactoryBot.create_list(:post, 10)
      get '/api/v1/posts'
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)

      # p response.status
      # p json
    end

    it '特定のpostを取得できるかの確認 show' do
      post = FactoryBot.create(:post, title: 'test-title')

      get "/api/v1/posts/#{post.id}"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['title']).to eq(post.title)

      # p response.status
      # p json
    end

    it 'postが作成できるかの確認 create' do
      user = { email: 'test@test.com', password: '123456' }
      auth_tokens = sign_in(user)

      post_params = { title: 'test_spec' }
      expect { post '/api/v1/posts', params: { post: post_params }, headers: { headers: auth_tokens } }.to change(Post, :count).by(+1)
      expect(response.status).to eq(200)

      # p response.headers
    end

    it 'postの編集を行う　put' do
      post = FactoryBot.create(:post, title: 'old_title')
      put "/api/v1/posts/#{post.id}", params: { post: { title: 'new_title' } }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['title']).to eq('new_title')
    end

    it 'postを削除できるかの確認 delete' do
      post = FactoryBot.create(:post, title: 'delete_test')
      delete "/api/v1/posts/#{post.id}"
      expect(response.status).to eq(200)
    end
  end
end
