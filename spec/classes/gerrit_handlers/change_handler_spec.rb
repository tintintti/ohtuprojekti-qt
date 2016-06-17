require 'rails_helper'
require Rails.root.to_s + '/app/classes/gerrit_handlers/change_handler.rb'

RSpec.describe ChangeHandler do
  before(:each) do
    change1 = FactoryGirl.build(:gerrit_change)
    change2 = FactoryGirl.build(:gerrit_change)
    change1.status = "MERGED"
    change2.status = "MERGED"
    change1.save
    change2.save
    FactoryGirl.create(:gerrit_message)
    FactoryGirl.create(:gerrit_message2)
  end

  it "average returns 0 if given an empty array" do
    expect(ChangeHandler.average []).to be(0)
  end

  it "passed_reviews returns an array of correct length" do
    passed = ChangeHandler.passed_reviews
    expect(passed.length).to be(2)
  end

  it "average_revisions returns an average of the number of revisions" do
    expect(ChangeHandler.average_revisions).to be(2)
  end

  it "revisions_needed_to_pass returns an array" do
    expect(ChangeHandler.revisions_needed_to_pass).to be_instance_of(Array)
  end

  it "time_to_pass returns an array" do
    expect(ChangeHandler.time_to_pass).to be_instance_of(Array)
  end

  it "time_to_pass returns a hash that contains key :label" do
    expect(ChangeHandler.time_to_pass.first).to have_key(:label)
  end

  it "time_to_pass returns a hash that contains key :value" do
    expect(ChangeHandler.time_to_pass.first).to have_key(:value)
  end

  it "revisions_needed_to_pass returns a hash that contains key :label" do
    expect(ChangeHandler.revisions_needed_to_pass.first).to have_key(:label)
  end

  it "revisions_needed_to_pass returns a hash that contains key :value" do
    expect(ChangeHandler.revisions_needed_to_pass.first).to have_key(:value)
  end

end
