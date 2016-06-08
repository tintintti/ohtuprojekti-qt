require 'rails_helper'

RSpec.describe "commits/show", type: :view do
  before(:each) do
    @commit = assign(:commit, Commit.create!(
      :repository_id => 1,
      :author_id => 2,
      :sha => "Sha",
      :stamp => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Sha/)
    expect(rendered).to match(/3/)
  end
end
