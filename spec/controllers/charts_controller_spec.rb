require 'rails_helper'

RSpec.describe ChartsController, type: :controller do

  describe "GET #forumCharts" do

    it "redirects to login page if trying to view charts without logging in" do
        get :forumCharts
        assert_redirected_to login_path
        assert_equal 'Et ole kirjautunut sisään.', flash[:alert]
    end

  end

end
