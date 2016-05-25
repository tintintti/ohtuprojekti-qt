FactoryGirl.define do
  factory :post do
    pid 1
    uid 1
    tid 1
    content "MyString"
    timestamp "a lot"
    reputation 1
    votes 1
    edited "stringToo"
    deleted false
  end
end
