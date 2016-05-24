require 'rails_helper'

RSpec.describe "topics/show", type: :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
      :tid => 1,
      :did => 2,
      :cid => "",
      :mainPid => 3,
      :title => "Title",
      :slug => "Slug",
      :timestamp => 4,
      :lastposttime => 5,
      :post => "Post",
      :count => 6,
      :viewcount => 7,
      :locked => false,
      :pinned => false,
      :isQuestion => 8,
      :isSolved => 9,
      :relativeTime => "Relative Time",
      :lastposttimeISO => "Lastposttime Iso"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Post/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/Relative Time/)
    expect(rendered).to match(/Lastposttime Iso/)
  end
end
