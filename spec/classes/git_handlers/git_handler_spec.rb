require 'rails_helper'
require Rails.root.to_s + '/app/classes/git_handlers/git_handler.rb'

RSpec.describe GitHandler do
  before(:each) do
    FactoryGirl.reload

    authors = FactoryGirl.build_list(:author, 5)
    commits = FactoryGirl.build_list(:commit, 5)

    Author.stubs(:all).returns(authors)
    Commit.stubs(:where).returns(commits)
  end

  it "author_commits returns right amount of authors" do
    expect(GitHandler.author_commits(0, 10).length).to be(5)
    expect(GitHandler.author_commits(0, 4).length).to be(4)
  end

end
