require 'rails_helper'

RSpec.describe "categories/new", type: :view do
  before(:each) do
    assign(:category, Category.new(
      :cid => 1,
      :name => "MyString",
      :description => "MyString",
      :slug => "MyString",
      :parentCid => "MyString",
      :topic_count => 1,
      :post_count => 1,
      :disabled => false,
      :order => 1,
      :link => "MyString",
      :numRecentReplies => 1,
      :totalPostCount => 1,
      :totalTopicCount => 1
    ))
  end

  it "renders new category form" do
    render

    assert_select "form[action=?][method=?]", categories_path, "post" do

      assert_select "input#category_cid[name=?]", "category[cid]"

      assert_select "input#category_name[name=?]", "category[name]"

      assert_select "input#category_description[name=?]", "category[description]"

      assert_select "input#category_slug[name=?]", "category[slug]"

      assert_select "input#category_parentCid[name=?]", "category[parentCid]"

      assert_select "input#category_topic_count[name=?]", "category[topic_count]"

      assert_select "input#category_post_count[name=?]", "category[post_count]"

      assert_select "input#category_disabled[name=?]", "category[disabled]"

      assert_select "input#category_order[name=?]", "category[order]"

      assert_select "input#category_link[name=?]", "category[link]"

      assert_select "input#category_numRecentReplies[name=?]", "category[numRecentReplies]"

      assert_select "input#category_totalPostCount[name=?]", "category[totalPostCount]"

      assert_select "input#category_totalTopicCount[name=?]", "category[totalTopicCount]"
    end
  end
end
