FactoryGirl.define do
  factory :gerrit_message do
    message_id "MyString"
    date "MyString"
    message "MyString"
    revision_number 1
    gerrit_owner_id 1
    gerrit_change_id 1
  end
end
