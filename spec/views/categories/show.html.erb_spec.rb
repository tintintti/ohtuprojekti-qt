require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/Parent Cid/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
  end
end
