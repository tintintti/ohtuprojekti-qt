require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do

    it "returns http success" do
      session[0]=1
      get :new
      expect(response).to have_http_status(:success)
    end
    
  end

  describe "POST #create" do

    before(:each) do
      request.env["HTTP_REFERER"] = "http://test.host/login"
    end

    it "redirects to root_path with welcome message when given correct credentials" do
      post :create, params = {username: 'tunnus', password: 'passu'}
       assert_redirected_to root_path
       assert_equal 'Tervetuloa!', flash[:notice]
    end

    it "login fails with an error message when given wrong credentials" do
      post :create, params = {username: 'kayttis', password: 'salis'}
       assert_equal 'Nimi tai salasana väärin.', flash[:alert]
    end

    describe "GET #destroy" do
      it "logs out the user" do
        get :destroy
        assert_equal 'Kirjauduit ulos.', flash[:notice]
      end
    end
  end

end
