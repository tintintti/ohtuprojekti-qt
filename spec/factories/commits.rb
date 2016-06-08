FactoryGirl.define do

  sequence(:random_ids) do |n|
    @random_ids ||= (1..100).to_a.shuffle
    @random_ids[n]
  end

  factory :random_commit, class:Commit do
    repository_id :random_ids
    author_id :random_ids
    sha "Random SHA"
    stamp 11111111
  end

  factory :simple_commit, class:Commit do
    repository_id :repository_id
    author_id :author_id
    sha "Simple sha"
    stamp 2222222
  end

  factory :author_commit, class:Commit do
    repository_id 1
    author_id :author_id
    sha "Simple sha"
    stamp 2222222
  end

  factory :commit do
    repository_id :repository_id
    author_id :author_id
    sha :sha
    stamp :stamp
  end
end
