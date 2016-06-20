FactoryGirl.define do
  factory :gerrit_owner do
    #account_id 1
    sequence(:account_id) { |n| n }
    sequence(:name) { |n| "testOwner#{n}" }
    email "daa@email.com"
  end
end
