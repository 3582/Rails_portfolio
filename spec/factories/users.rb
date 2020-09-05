FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    # ( min_length:8, max_length:16, mix_case:true ) }
    password_confirmation { password }
  end
end
