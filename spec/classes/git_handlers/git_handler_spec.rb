require 'rails_helper'
require Rails.root.to_s + '/app/classes/git_handlers/git_handler.rb'

RSpec.describe GitHandler do
  before(:each) do
    FactoryGirl.reload

    authors = FactoryGirl.create_list(:author, 5)
    Author.stubs(:all).returns(authors)
  end

  it "author_commits returns right amount of authors" do
    expect(GitHandler.author_commits("01/01/2000", 10).length).to be(5)
    expect(GitHandler.author_commits("01/01/2000", 4).length).to be(4)
  end

  it "author_emails returns emails" do
    expect(GitHandler.author_emails().length).to be(1)
    expect(GitHandler.author_emails()[0][:value]).to be(4)
    GitHandler.author_commits("01/01/2000", 6)
    expect(GitHandler.author_emails()[0][:value]).to be(5)
    expect(GitHandler.author_emails()[0][:label]).to eq("test")
  end
end
