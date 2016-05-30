FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "testUser#{n}" }
    sequence(:userslug) { |n| "testuser#{n}" }
    sequence(:email) { |n| "testuser#{n}@test.fi" }
    picture "MyString"
    fullname "MyString"
    signature "MyString"
    reputation 1
    postcount 1
    banned false
    status "MyString"
    sequence(:uid) { |n| n }
    lastonline "string?"
  end
end
