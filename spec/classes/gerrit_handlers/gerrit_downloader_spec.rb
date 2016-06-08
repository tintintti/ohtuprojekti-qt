require 'rails_helper'
require "#{Rails.root}/app/classes/gerrit_handlers/gerrit_downloader.rb"

RSpec.describe GerritDownloader do

  before :each do
    @downloader = GerritDownloader.new
    projects   = IO.read "spec/fixtures/projects.json"
    changes    = IO.read "spec/fixtures/changes.json"

    stub_request(:get, "https://codereview.qt-project.org/projects/").
       with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
       to_return(status: 200, body: projects, headers: {})

    stub_request(:get, "https://codereview.qt-project.org/changes/").
       with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: changes, headers: {})

  end

  it "body_no_first_line removes the first line of the response" do
    response = HTTParty.get("https://codereview.qt-project.org/projects/")
    body     = @downloader.body_no_first_line(response)
    expect(body).not_to start_with(")]}'")
  end

  it "projects returns a hash" do
    expect(@downloader.projects).to be_instance_of(Hash)
  end

  it "changes returns an array" do
    expect(@downloader.changes).to be_instance_of(Array)
  end

end
