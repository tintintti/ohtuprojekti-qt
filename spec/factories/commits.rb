FactoryGirl.define do

  factory :commit do
    repository_id 1
    sequence(:author_id) { |n| n }
    sha "sha"
    stamp 1420070401
  end

end
