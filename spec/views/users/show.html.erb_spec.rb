require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :username => "Username",
      :userslug => "Userslug",
      :email => "Email",
      :picture => "Picture",
      :fullname => "Fullname",
      :signature => "Signature",
      :reputation => 1,
      :postcount => 2,
      :banned => false,
      :status => "Status",
      :did => 3,
      :lastonline => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Userslug/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Picture/)
    expect(rendered).to match(/Fullname/)
    expect(rendered).to match(/Signature/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
