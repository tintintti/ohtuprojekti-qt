require 'rails_helper'

RSpec.describe "commits/edit", type: :view do
  before(:each) do
    @commit = assign(:commit, Commit.create!(
      :repository_id => 1,
      :author_id => 1,
      :sha => "MyString",
      :stamp => 1
    ))
  end

  it "renders the edit commit form" do
    render

    assert_select "form[action=?][method=?]", commit_path(@commit), "post" do

      assert_select "input#commit_repository_id[name=?]", "commit[repository_id]"

      assert_select "input#commit_author_id[name=?]", "commit[author_id]"

      assert_select "input#commit_sha[name=?]", "commit[sha]"

      assert_select "input#commit_stamp[name=?]", "commit[stamp]"
    end
  end
end
