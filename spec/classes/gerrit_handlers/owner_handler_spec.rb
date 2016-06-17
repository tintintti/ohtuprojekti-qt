require 'rails_helper'
require Rails.root.to_s + '/app/classes/gerrit_handlers/owner_handler.rb'

RSpec.describe OwnerHandler do
  it "changes_by_owner returns an array" do
    expect(OwnerHandler.changes_by_owner).to be_instance_of(Array)
  end
end
