require 'rails_helper'
require Rails.root.to_s + '/app/classes/forum_handlers/user_handler.rb'


RSpec.describe UserHandler do

  before(:each) do
    User.stubs(:all).returns([FactoryGirl.build(:user), FactoryGirl.build(:user2), FactoryGirl.build(:user3), FactoryGirl.build(:usercom)])
    User.stubs(:find_by_uid).with(1).returns(FactoryGirl.build(:user))
    User.stubs(:find_by_uid).with(5).returns(nil)
  end

  it "user_postcounts returns an array" do
    expect(UserHandler.user_postcounts).to be_instance_of(Array)
  end

  it "users_by_email_provider returns a hash" do
    expect(UserHandler.users_by_email_provider).to be_instance_of(Hash)
  end

  it "users_by_email_provider returns a hash of the right length" do
    expect(UserHandler.users_by_email_provider.length).to be(2)
  end

  it "users_by_email_provider has the right amount of users for each email" do
    expect(UserHandler.users_by_email_provider["test"].length).to be(3)
    expect(UserHandler.users_by_email_provider["test2"].length).to be(1)
  end

  it "users_by_email_provider return a hash with right values" do
    expect(UserHandler.users_by_email_provider["test"][0]).to eq({user:"testUser1", slug:"testuser1"})
    expect(UserHandler.users_by_email_provider["test"][1]).to eq({user:"testUser2", slug:"testuser2"})
  end

  it "counts users with same email provider but with different top level domain to the same provider" do
    expect(UserHandler.users_by_email_provider["test"].length).to be(3)
  end

  it "user_postcounts sets 'removed user' if post's user is nil" do
    Post.stubs(:all).returns([FactoryGirl.create(:topic_no_user)])
    expect(UserHandler.user_postcounts[0][:label]).to eq("removed user")
  end

  it "user_postcounts sets the user correctly if the user isn't nil" do

  end

end
