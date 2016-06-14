FactoryGirl.define do
  factory :gerrit_sanity_review do
    change_id_from_gerrit "MyString"
    gerrit_change_id 1
    gerrit_owner_id 1
    value 1
  end
end
