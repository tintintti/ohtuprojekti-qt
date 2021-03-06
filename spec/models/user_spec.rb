require 'rails_helper'
require 'httparty'
#include DatabaseHelpers

RSpec.describe User, type: :model do
  describe "User" do
    it 'is created correctly with correct parameters' do
      params = DatabaseHelpers.get_user
      user = User.create(
        username:params["username"],
        userslug:params["userslug"],
        email:params["email"],
        picture:params["picture"],
        fullname:params["fullname"],
        signature:params["signature"],
        reputation:params["reputation"],
        postcount:params["postcount"],
        banned:params["banned"],
        status:params["status"],
        uid:params["uid"],
        lastonline:params["lastonline"],


      )

      expect(user).to be_valid
      expect(user.username).to eq("opengpu2")
      expect(user.userslug).to eq("opengpu2")
      expect(user.email).to eq("opengpu@foxmail.com")
      expect(user.picture).to eq("https://www.gravatar.com/avatar/ecaf594601aaf2df692e91ab97bf51a1?size=192&d=mm")
      expect(user.fullname).to eq("")
      expect(user.signature).to eq("")
      expect(user.reputation).to eq(2)
      expect(user.postcount).to eq(419)
      expect(user.banned).to eq(false)
      expect(user.status).to eq("offline")
      expect(user.uid).to eq(20121)
      expect(user.lastonline).to eq("1464159234766")
    end

    it 'validates correctly by user id' do
      User.create uid:2
      User.create uid:2
      expect(User.all.count).to eq(1)
    end

    it 'isnt created without user id' do
      user = User.create userslug:"www.http.com"
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "returns the right amount of posts with ret_posts" do
      FactoryGirl.reload
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:post)
      post2 = FactoryGirl.build(:post)
      post2.uid = 1
      post2.save
      expect(user.ret_posts.length).to be(2)
    end

    it "returns the right posts with ret_posts" do
      FactoryGirl.reload
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      expect(user.ret_posts).to include(post)
    end

    it "returns the right topics with ret_topics" do
      FactoryGirl.reload
      user  = FactoryGirl.create(:user)
      topic = FactoryGirl.create(:topic)
      expect(user.ret_topics).to include(topic)
    end

  end
end
