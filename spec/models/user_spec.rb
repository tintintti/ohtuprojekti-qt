require 'rails_helper'
require 'httparty'
#include DatabaseHelpers

RSpec.describe User, type: :model do
  describe "user is created correctly" do
    it 'creates user with correct parameters' do
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

    it 'validates user correctly by username' do
      User.create username:"Ola"
      User.create username:"Ola"
      expect(User.all.count).to eq(1)
    end
  end
end
