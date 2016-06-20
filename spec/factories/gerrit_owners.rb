FactoryGirl.define do
  factory :gerrit_owner do
    sequence(:account_id) { |n| n }
<<<<<<< HEAD
    name "TestOwner1"
=======
    sequence(:name) { |n| "testOwner#{n}" }
>>>>>>> 9844f8c5f02be2459833f82740cf3f71d02acadd
    email "daa@email.com"
  end
end
