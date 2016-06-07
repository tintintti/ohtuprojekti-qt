FactoryGirl.define do
  factory :post do
    sequence(:pid) { |n| n }
    sequence(:uid) { |n| n }
    tid 1
    content "post"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
    sequence(:index) { |n| n - 1 }
  end

  factory :post_no_user, class:Post do
    pid 4
    uid 5
    tid 1
    content "post without a valid user"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
  end
  
  factory :post_user_one, class:Post do
    sequence(:pid) { |n| n + 100 }
    uid 1
    tid 1
    content "post"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
    sequence(:index) { |n| n - 1 }
  end
end
