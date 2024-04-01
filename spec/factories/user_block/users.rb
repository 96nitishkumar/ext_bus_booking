FactoryBot.define do
  factory :user_block_user, class: 'UserBlock::User' do
    name { "MyString" }
    password_digest { "MyString" }
    email { "MyString" }
  end
end
