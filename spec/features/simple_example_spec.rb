require 'capybara/poltergeist'

# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
# end

Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
# Capybara.javascript_driver = :poltergeist
Capybara.javascript_driver = :chrome

require 'rails_helper'

describe "Main page", :js => true do

  it "should have gmail" do
    visit('/')
    save_and_open_page
    expect(page).to have_content 'gmail'
  end
end
