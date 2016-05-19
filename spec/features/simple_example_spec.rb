require 'capybara'
#
# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
# end

Capybara.register_driver :selenium do |app|
      options = {
        timeout: 360,
        js_errors: false,
        logger: nil,
        phantomjs_options:
        [
          '--load-images=no',
          '--ignore-ssl-errors=yes'
        ]
      }
      Capybara::Selenium::Driver.new app, :browser => :firefox
end
# Capybara.register_driver(:poltergeist) do |app|
#     Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path),
#   end
# Capybara.javascript_driver = :chrome
# Capybara.javascript_driver = :poltergeist

require 'rails_helper'

describe "Main page", :js => true do

  it "should have gmail" do
    visit('/welcome/index')
    # save_and_open_page
    expect(page).to have_content 'gmail'
  end
end
