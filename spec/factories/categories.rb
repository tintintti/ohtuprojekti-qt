FactoryGirl.define do
  factory :category do
    cid 1
    name "MyString"
    description "MyString"
    slug "MyString"
    parentCid "MyString"
    topic_count 1
    post_count 1
    disabled false
    order 1
    link "MyString"
    numRecentReplies 1
    totalPostCount 1
    totalTopicCount 1
  end
end
