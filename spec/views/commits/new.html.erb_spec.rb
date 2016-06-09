require 'rails_helper'

RSpec.describe "commits/new", type: :view do
  before(:each) do
    assign(:commit, Commit.new(
      :repository_id => 1,
      :author_id => 1,
      :sha => "MyString",
      :stamp => 1
    ))
  end

  it "renders new commit form" do
    render

    assert_select "form[action=?][method=?]", commits_path, "post" do

      assert_select "input#commit_repository_id[name=?]", "commit[repository_id]"

      assert_select "input#commit_author_id[name=?]", "commit[author_id]"

      assert_select "input#commit_sha[name=?]", "commit[sha]"

      assert_select "input#commit_stamp[name=?]", "commit[stamp]"
    end
  end
end
