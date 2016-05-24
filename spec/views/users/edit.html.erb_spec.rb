require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :username => "MyString",
      :userslug => "MyString",
      :email => "MyString",
      :picture => "MyString",
      :fullname => "MyString",
      :signature => "MyString",
      :reputation => 1,
      :postcount => 1,
      :banned => false,
      :status => "MyString",
      :did => 1,
      :lastonline => 1
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_username[name=?]", "user[username]"

      assert_select "input#user_userslug[name=?]", "user[userslug]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_picture[name=?]", "user[picture]"

      assert_select "input#user_fullname[name=?]", "user[fullname]"

      assert_select "input#user_signature[name=?]", "user[signature]"

      assert_select "input#user_reputation[name=?]", "user[reputation]"

      assert_select "input#user_postcount[name=?]", "user[postcount]"

      assert_select "input#user_banned[name=?]", "user[banned]"

      assert_select "input#user_status[name=?]", "user[status]"

      assert_select "input#user_did[name=?]", "user[did]"

      assert_select "input#user_lastonline[name=?]", "user[lastonline]"
    end
  end
end
