require 'rails_helper'

RSpec.describe GerritDownloader do

  before :each do
    @downloader = GerritDownloader.new
    projects    = IO.read "spec/fixtures/projects.json"
    changes     = IO.read "spec/fixtures/changes.json"

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

  it "download_and_parse returns nil if response code not 200" do
    stub_request(:get, "https://codereview.qt-project.org/changes/").
       with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(status: 404, body: nil, headers: {})

    returned = @downloader.download_and_parse('https://codereview.qt-project.org/changes/')
    expect(returned).to be(nil)
  end

end
