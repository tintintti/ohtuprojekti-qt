require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      post session_path, :username => "tunnus", :password => 'passu'
      get posts_path
      expect(response).to have_http_status(200)
    end
  end
end
