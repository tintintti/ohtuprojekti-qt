FactoryGirl.define do
  factory :gerrit_owner do
    sequence(:account_id) { |n| n }
    name "TestOwner1"
    email "daa@email.com"
  end
end
