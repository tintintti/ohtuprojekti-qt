FactoryGirl.define do
  factory :user do
    username "testUser1"
    userslug "testuser1"
    email "testuser1@test.fi"
    picture "MyString"
    fullname "MyString"
    signature "MyString"
    reputation 1
    postcount 1
    banned false
    status "MyString"
    uid 1
    lastonline "string?"
  end
  factory :user2, class: User do
    username "testUser2"
    userslug "testuser2"
    email "testuser2@test.fi"
    picture "MyString"
    fullname "MyString"
    signature "MyString"
    reputation 1
    postcount 1
    banned false
    status "MyString"
    uid 2
    lastonline "string?"
  end

  factory :usercom, class: User do
    username "testUserCom"
    userslug "testusercom"
    email "testuser2@test.com"
    picture "MyString"
    fullname "MyString"
    signature "MyString"
    reputation 1
    postcount 1
    banned false
    status "MyString"
    uid 3
    lastonline "string?"
  end

  factory :user3, class: User do
    username "testUser3"
    userslug "testuser3"
    email "testuser3@test2.fi"
    picture "MyString"
    fullname "MyString"
    signature "MyString"
    reputation 1
    postcount 1
    banned false
    status "MyString"
    uid 4
    lastonline "string?"
  end
end
