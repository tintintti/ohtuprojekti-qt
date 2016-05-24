require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      :pid => 1,
      :did => 1,
      :tid => 1,
      :content => "MyString",
      :timestamp => 1,
      :reputation => 1,
      :votes => 1,
      :edited => 1,
      :deleted => false
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_pid[name=?]", "post[pid]"

      assert_select "input#post_did[name=?]", "post[did]"

      assert_select "input#post_tid[name=?]", "post[tid]"

      assert_select "input#post_content[name=?]", "post[content]"

      assert_select "input#post_timestamp[name=?]", "post[timestamp]"

      assert_select "input#post_reputation[name=?]", "post[reputation]"

      assert_select "input#post_votes[name=?]", "post[votes]"

      assert_select "input#post_edited[name=?]", "post[edited]"

      assert_select "input#post_deleted[name=?]", "post[deleted]"
    end
  end
end
