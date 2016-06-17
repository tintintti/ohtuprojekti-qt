FactoryGirl.define do
  factory :gerrit_change do
    kind "MyString"
    sequence(:id_from_gerrit) { |n| n }
    project "MyString"
    branch "MyString"
    change_id "MyString"
    subject "MyString"
    status "NEW"
    created "2016-06-14 06:49:35.301000000"
    updated "2016-06-14 11:06:36.499000000"
    mergeable false
    sortkey "MyString"
    number 1
    gerrit_owner_id 1
  end
end
