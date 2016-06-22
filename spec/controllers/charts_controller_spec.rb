require 'rails_helper'

RSpec.describe ChartsController, type: :controller do

  describe "having not logged in" do

    it "can access the front page" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "cannot access charts" do
      get :forumCharts
      assert_redirected_to login_path
      assert_equal 'You must log in first.', flash[:alert]
    end

  end

  describe "having logged in" do

    before(:each) do
      session[0]=1
    end

    it "going to forum charts works" do
      get :forumCharts
      expect(response).to have_http_status(:success)
    end

    it "going to git charts works" do
      get :gitCharts
      expect(response).to have_http_status(:success)
    end

    it "going to git charts with data works" do
      user = FactoryGirl.create(:commit)
      users = Array.new
      users << user
      Commit.stubs(:all).returns(users)
      get :gitCharts
      expect(response).to have_http_status(:success)
    end

    it "going to gerrit charts works" do
      get :gerritCharts
      expect(response).to have_http_status(:success)
    end

  end

end
