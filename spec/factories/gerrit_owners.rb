FactoryGirl.define do
  factory :gerrit_owner do
    #account_id 1
    sequence(:account_id) { |n| n }
    name "MyString"
    email "MyString"
  end
end
