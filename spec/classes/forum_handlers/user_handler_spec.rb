require 'rails_helper'
require Rails.root.to_s + '/app/classes/forum_handlers/user_handler.rb'

RSpec.describe UserHandler do

  it "user_postcounts returns an array" do
    expect(UserHandler.user_postcounts).to be_instance_of(Array)
  end

  it "users_by_email_provider returns a hash" do
    expect(UserHandler.users_by_email_provider).to be_instance_of(Hash)
  end

  it "users_by_email_provider returns a hash of the right length" do
    User.stubs(:all).returns([FactoryGirl.build(:user2)])
    expect(UserHandler.users_by_email_provider.length).to be(1)
  end

  it "users_by_email_provider has the right amount of users for each email" do
    User.stubs(:all).returns([FactoryGirl.build(:user), FactoryGirl.build(:user2), FactoryGirl.build(:user3)])
    expect(UserHandler.users_by_email_provider["test"].length).to be(2)
    expect(UserHandler.users_by_email_provider["test2"].length).to be(1)
  end

  it "users_by_email_provider return a hash with right values" do
    User.stubs(:all).returns([FactoryGirl.build(:user), FactoryGirl.build(:user2), FactoryGirl.build(:user3)])
    expect(UserHandler.users_by_email_provider["test"][0]).to eq({user:"MyString", slug:"MyString"})
    expect(UserHandler.users_by_email_provider["test"][1]).to eq({user:"testUser2", slug:"testuser2"})
  end

  it "counts users with same email provider but with different top level domain to the same provider" do
    User.stubs(:all).returns([FactoryGirl.build(:user), FactoryGirl.build(:user2), FactoryGirl.build(:usercom)])
    expect(UserHandler.users_by_email_provider["test"].length).to be(3)
  end

  it "format_email returns same for two emails with same provider but different tld" do
    expect(UserHandler.format_email("testing@test.fi")).to eq(UserHandler.format_email("asd@test.com"))
  end

end
