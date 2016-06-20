require 'rails_helper'
require Rails.root.to_s + '/app/classes/gerrit_handlers/owner_handler.rb'

RSpec.describe OwnerHandler do
  before(:each) do
    FactoryGirl.reload
    FactoryGirl.create(:gerrit_owner)
    FactoryGirl.create(:gerrit_change)
    FactoryGirl.create(:gerrit_change)
  end

  it "changes_by_owner returns an array" do
    expect(OwnerHandler.changes_by_owner).to be_instance_of(Array)
  end

  it "changes_by_owner returns an array with the owner name" do
    changes = OwnerHandler.changes_by_owner
    expect(changes.any? { |change| change[:label] == 'testOwner1' }).to be(true)
  end

  it "changes_by_owner returns an array with the rigth amount of changes for the owner" do
    changes = OwnerHandler.changes_by_owner
    expect(changes.any? { |change| change[:label] == 'testOwner1' && change[:value] == 2 }).to be(true)
  end

  describe "owner_domains" do
    it "returns an instance of Array" do
      expect(OwnerHandler.owner_domains).to be_instance_of(Array)
    end

    it "returns a correct amount of domains in array" do
      expect(OwnerHandler.owner_domains.length).to eq(1)
    end

    it "returns a correct array containing domains of changes" do
      expect(OwnerHandler.owner_domains[0][:value]).to eq(1)
    end
  end

end
