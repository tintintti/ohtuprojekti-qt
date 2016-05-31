require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    it "works! (now write some real specs)" do
      post session_path, :username => "tunnus", :password => 'passu'
      get categories_path
      expect(response).to have_http_status(200)
    end
  end
end
