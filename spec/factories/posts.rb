FactoryGirl.define do
  factory :post do
    pid 1
    uid 1
    tid 1
    content "post 1"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
  end
  factory :post2, class:Post do
    pid 2
    uid 1
    tid 1
    content "post 2"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
  end
  factory :post3, class:Post do
    pid 3
    uid 2
    tid 1
    content "post 3"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
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
end
