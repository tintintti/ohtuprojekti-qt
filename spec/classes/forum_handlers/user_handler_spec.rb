require 'rails_helper'
require Rails.root.to_s + '/app/classes/forum_handlers/user_handler.rb'
#require Dir["#{Rails.root}/app/classes/forum_handlers/user_handler.rb"]

RSpec.describe UserHandler do

  it "user_postcounts returns an array" do
    expect(UserHandler.user_postcounts).to be_instance_of(Array)
  end

  it "users_by_email returns a hash" do
    expect(UserHandler.users_by_email_provider).to be_instance_of(Hash)
  end

end
