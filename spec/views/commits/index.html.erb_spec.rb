require 'rails_helper'

RSpec.describe "commits/index", type: :view do
  before(:each) do
    assign(:commits, [
      Commit.create!(
        :repository_id => 1,
        :author_id => 2,
        :sha => "Sha",
        :stamp => 3
      ),
      Commit.create!(
        :repository_id => 1,
        :author_id => 2,
        :sha => "Sha",
        :stamp => 3
      )
    ])
  end

  it "renders a list of commits" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Sha".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
