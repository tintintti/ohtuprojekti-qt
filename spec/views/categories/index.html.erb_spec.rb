require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    assign(:categories, [
      Category.create!(
        :cid => 1,
        :name => "Name",
        :description => "Description",
        :slug => "Slug",
        :parentCid => "Parent Cid",
        :topic_count => 2,
        :post_count => 3,
        :disabled => false,
        :order => 4,
        :link => "Link",
        :numRecentReplies => 5,
        :totalPostCount => 6,
        :totalTopicCount => 7
      ),
      Category.create!(
        :cid => 1,
        :name => "Name",
        :description => "Description",
        :slug => "Slug",
        :parentCid => "Parent Cid",
        :topic_count => 2,
        :post_count => 3,
        :disabled => false,
        :order => 4,
        :link => "Link",
        :numRecentReplies => 5,
        :totalPostCount => 6,
        :totalTopicCount => 7
      )
    ])
  end

  it "renders a list of categories" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Cid".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end
