FactoryGirl.define do
  factory :gerrit_message do
    message_id "MyString"
    date "2016-06-14 07:49:35.301000000"
    message "Continuous Integration: Passed blaa blaa"
    revision_number 1
    gerrit_owner_id 1
    gerrit_change_id 1
  end
  factory :gerrit_message2, class: GerritMessage do
    message_id "MyString"
    date "2016-06-14 08:49:35.301000000"
    message "Continuous Integration: Passed blaa blaa"
    revision_number 4
    gerrit_owner_id 1
    gerrit_change_id 2
  end
end
