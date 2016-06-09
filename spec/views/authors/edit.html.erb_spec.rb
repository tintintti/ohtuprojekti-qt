require 'rails_helper'

RSpec.describe "authors/edit", type: :view do
  before(:each) do
    @author = assign(:author, Author.create!(
      :name => "MyString",
      :email => "MyString",
      :linked_id => 1
    ))
  end

  it "renders the edit author form" do
    render

    assert_select "form[action=?][method=?]", author_path(@author), "post" do

      assert_select "input#author_name[name=?]", "author[name]"

      assert_select "input#author_email[name=?]", "author[email]"

      assert_select "input#author_linked_id[name=?]", "author[linked_id]"
    end
  end
end
