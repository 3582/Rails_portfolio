require 'rails_helper'

RSpec.describe 'Posts', :type => :request do
  describe '/api/v1/posts' do
    let(:user) { create(:user) }
    before do
      new_user = { :email => user.email, :password => user.password, :password_confirmation => user.password }
      sign_up(new_user)
      @auth_tokens = sign_in(new_user)
    end
    it '10件取得できるかの確認 index' do
      create_list(:post, 10)
      get '/api/v1/posts'
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end

    it '特定のpostを取得できるかの確認 show' do
      post = create(:post)
      get "/api/v1/posts/#{post.id}"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json['title']).to eq(post.title)
    end

    it 'postが作成できるかの確認 create' do
      post_params = { :title => 'test_spec', :text => 'test_text', :tag_name => 'test_tag' }
      post '/api/v1/posts', :params =>  post_params , :headers => @auth_tokens
      expect(response).to have_http_status(200)
    end

    it 'postの編集を行う　put' do
      post = create(:post, :title => 'old_title')
      new_params = { :title => 'new_spec', :text => 'new_text', :tag_name => 'test_tag' }
      put "/api/v1/posts/#{post.id}", :params =>  new_params , :headers => @auth_tokens
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json['title']).to eq('new_spec')
    end

    it 'postを削除できるかの確認 delete' do
      post = create(:post, :title => 'delete_test')
      delete "/api/v1/posts/#{post.id}", :headers => @auth_tokens
      expect(response).to have_http_status(200)
    end
  end
end
