require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        :pid => 1,
        :did => 2,
        :tid => 3,
        :content => "Content",
        :timestamp => 4,
        :reputation => 5,
        :votes => 6,
        :edited => 7,
        :deleted => false
      ),
      Post.create!(
        :pid => 1,
        :did => 2,
        :tid => 3,
        :content => "Content",
        :timestamp => 4,
        :reputation => 5,
        :votes => 6,
        :edited => 7,
        :deleted => false
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
