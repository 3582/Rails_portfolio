FactoryBot.define do
  factory :post do
    title {'title_rspec'}
    text {'text_rspec'}
    user_id {FactoryBot.create(:user).id}

  end
end
