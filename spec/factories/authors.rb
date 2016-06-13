FactoryGirl.define do

  factory :author do
    sequence(:name) { |n| "testAuthor#{n}" }
    sequence(:email) { |n| "author#{n}@test.fi" }
    linked_id nil
  end

end
