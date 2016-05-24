require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :pid => 1,
      :did => 2,
      :tid => 3,
      :content => "Content",
      :timestamp => 4,
      :reputation => 5,
      :votes => 6,
      :edited => 7,
      :deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/false/)
  end
end
