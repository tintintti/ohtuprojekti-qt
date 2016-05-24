require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
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
      ),
      User.create!(
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
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Userslug".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Picture".to_s, :count => 2
    assert_select "tr>td", :text => "Fullname".to_s, :count => 2
    assert_select "tr>td", :text => "Signature".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
