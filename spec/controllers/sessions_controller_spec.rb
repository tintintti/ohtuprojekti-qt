require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "going to login page" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "when logging in" do

    before(:each) do
      request.env["HTTP_REFERER"] = "http://test.host/login"
    end

    it "redirects to root_path with welcome message when given correct credentials" do
      post :create, params = {username: 'tunnus', password: 'passu'}
       assert_redirected_to root_path
       assert_equal 'Welcome!', flash[:notice]
    end

    it "fails with an error message when given wrong credentials" do
      post :create, params = {username: 'kayttis', password: 'salis'}
       expect(response).to have_http_status(:redirect)
       assert_equal 'Invalid username or password.', flash[:alert]
    end

    describe "when logging out" do
      it "logs out the user" do
        get :destroy
        assert_equal 'Logged out.', flash[:notice]
      end
    end
  end

end
