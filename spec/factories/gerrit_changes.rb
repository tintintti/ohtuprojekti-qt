FactoryGirl.define do
  factory :gerrit_change do
    kind "MyString"
    id_from_gerrit "MyString"
    project "MyString"
    branch "MyString"
    change_id "MyString"
    subject "MyString"
    status "MyString"
    created "MyString"
    updated "MyString"
    mergeable false
    sortkey "MyString"
    number 1
    gerrit_owner_id 1
  end
end
