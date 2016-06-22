FactoryGirl.define do
  factory :gerrit_change do
    kind "MyString"
    sequence(:id_from_gerrit) { |n| n }
    project "MyString"
    branch "MyString"
    change_id "MyString"
    subject "MyString"
    status "MERGED"
    created "2016-06-14 06:49:35.301000000"
    updated "2016-06-14 11:06:36.499000000"
    mergeable false
    sortkey "MyString"
    number 1
    gerrit_owner_id 1
    after(:build) do |change|
      change.gerrit_messages << FactoryGirl.build(:gerrit_message, :gerrit_change_id => change)
    end
  end
end
