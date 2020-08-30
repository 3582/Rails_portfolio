require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /api/v1/posts" do
   
    before  '10件のpost' do
      FactoryBot.create_list(:post, 10)
      get '/api/v1/posts'
   end

   it "200を返すかの確認" do
      expect(response.status).to eq(200)
      p response.status
   end

   it "10件存在するかの確認" do
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
      p json
   end

   it "特定のpostを取得する" do
     post = FactoryBot.create(:post, title: "test-title")

     get "/api/v1/posts/#{post.id}"
     json = JSON.parse(response.body)
     expect(response.status).to eq(200)
     p response.status
     expect(json["title"]).to eq(post.title)
     p json
   end

  end
end
