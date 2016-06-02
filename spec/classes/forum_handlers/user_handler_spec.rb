require 'rails_helper'
require Rails.root.to_s + '/app/classes/forum_handlers/user_handler.rb'


RSpec.describe UserHandler do

  before(:each) do
    FactoryGirl.reload

    user1 = FactoryGirl.build(:user, email: "test@test2.com")
    users = FactoryGirl.build_list(:user, 2)
    users << user1

    User.stubs(:all).returns(users)
    User.stubs(:find_by_uid).with(1).returns(user1)
    User.stubs(:find_by_uid).with(5).returns(nil)
  end

  it "users_by_email_provider returns a hash" do
    expect(UserHandler.users_by_email_provider).to be_instance_of(Hash)
  end

  it "users_by_email_provider returns a hash of the right length" do
    expect(UserHandler.users_by_email_provider.length).to be(2)
  end

  it "users_by_email_provider has the right amount of users for each email" do
    expect(UserHandler.users_by_email_provider["test"].length).to be(2)
    expect(UserHandler.users_by_email_provider["test2"].length).to be(1)
  end

  it "users_by_email_provider return a hash with right values" do
    expect(UserHandler.users_by_email_provider["test2"]).to include({user:"testUser1", slug:"testuser1"})
  end

  it "counts users with same email provider but with different top level domain to the same provider" do
    usercom = FactoryGirl.build(:user)
    usercom.email = "testmail@test.com"
    User.stubs(:all).returns([FactoryGirl.build(:user), usercom])
    expect(UserHandler.users_by_email_provider["test"].length).to be(2)
  end

  it "doesn't count nil emails" do
    user = FactoryGirl.build(:user)
    user.email = nil
    User.stubs(:all).returns([user])
    expect(UserHandler.users_by_email_provider.length).to be(0)
  end

  it "count_emails includes the correct email providers" do
    expect(UserHandler.count_emails).to include(label: "test", value: 2)
    expect(UserHandler.count_emails).to include(label: "test2", value: 1)
  end

  it "user_postcounts returns an array" do
    expect(UserHandler.user_postcounts).to be_instance_of(Array)
  end

  it "user_postcounts sets the username correctly if the user isn't nil" do
    Post.stubs(:all).returns([FactoryGirl.build(:post)])
    expect(UserHandler.user_postcounts[0]).to include({label: "testUser1", value: 1})
  end

  it "user_postcounts sets 'removed user' if post's user is nil" do
    Post.stubs(:all).returns([FactoryGirl.create(:post_no_user)])
    expect(UserHandler.user_postcounts[0][0][:label]).to eq("removed user")
  end

end
