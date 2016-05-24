require 'rails_helper'

RSpec.describe "topics/show", type: :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/Relative Time/)
    expect(rendered).to match(/Lastposttime Iso/)
  end
end
