FactoryGirl.define do

  factory :author do
    sequence(:name) { |n| "testAuthor#{n}" }
    sequence(:email) { |n| "author#{n}@test.fi" }
    linked_id nil
    after(:build) do |author|
      author.commits << FactoryGirl.build(:commit, :author_id => author)
    end

  end

end
