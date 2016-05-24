require 'rails_helper'

RSpec.describe "topics/index", type: :view do
  before(:each) do
    assign(:topics, [
      Topic.create!(
        :tid => 1,
        :uid => 2,
        :cid => 3,
        :mainPid => 4,
        :title => "Title",
        :slug => "Slug",
        :timestamp => 5,
        :lastposttime => 6,
        :postcount => 7,
        :viewcount => 8,
        :locked => false,
        :pinned => false,
        :isQuestion => 9,
        :isSolved => 10,
        :relativeTime => "Relative Time",
        :lastposttimeISO => "Lastposttime Iso"
      ),
      Topic.create!(
        :tid => 1,
        :uid => 2,
        :cid => 3,
        :mainPid => 4,
        :title => "Title",
        :slug => "Slug",
        :timestamp => 5,
        :lastposttime => 6,
        :postcount => 7,
        :viewcount => 8,
        :locked => false,
        :pinned => false,
        :isQuestion => 9,
        :isSolved => 10,
        :relativeTime => "Relative Time",
        :lastposttimeISO => "Lastposttime Iso"
      )
    ])
  end

  it "renders a list of topics" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => "Relative Time".to_s, :count => 2
    assert_select "tr>td", :text => "Lastposttime Iso".to_s, :count => 2
  end
end
