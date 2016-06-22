require 'rails_helper'
require Rails.root.to_s + '/app/classes/gerrit_handlers/change_handler.rb'

RSpec.describe ChangeHandler do
  before(:each) do
    FactoryGirl.reload
    change1 = FactoryGirl.build(:gerrit_change)
    change2 = FactoryGirl.build(:gerrit_change)
    change1.status = "MERGED"
    change2.status = "MERGED"
    change1.save
    change2.save
    FactoryGirl.create(:gerrit_message)
    change2.gerrit_messages = [] << FactoryGirl.create(:gerrit_message2)
  end

  it "average returns 0 if given an empty array" do
    expect(ChangeHandler.average []).to be(0)
  end

  it "passed_reviews returns an array of correct length" do
    passed = ChangeHandler.passed_reviews
    expect(passed.length).to be(2)
  end

  it "average_revisions returns an average of the number of revisions" do
    expect(ChangeHandler.average_revisions).to be(1)
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

  it "change_data includes keys :times and :revisions" do
    expect(ChangeHandler.change_data).to have_key(:times)
    expect(ChangeHandler.change_data).to have_key(:revisions)
  end

  it "change_data returns a hash with arrays as values" do
    data = ChangeHandler.change_data
    expect(data[:times]).to     be_instance_of(Array)
    expect(data[:revisions]).to be_instance_of(Array)
  end

  it "averages includes keys :time and :revisions" do
    expect(ChangeHandler.averages).to have_key(:time)
    expect(ChangeHandler.averages).to have_key(:revisions)
  end

  it "average_time returns 0 if there are time_to_pass is empty" do
    ChangeHandler.stubs(:time_to_pass).returns([])
    expect(ChangeHandler.average_time).to be(0)
  end

  it "average_time returns the average of the times got from time_to_pass" do
    value1 = 200
    value2 = 400
    ChangeHandler.stubs(:time_to_pass).returns([{label: 1, value: value1}, {label: 2, value: value2}])
    expect(ChangeHandler.average_time).to be((value1 + value2) / 2)
  end


end
