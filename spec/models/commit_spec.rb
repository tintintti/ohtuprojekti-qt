require 'rails_helper'

RSpec.describe Commit, type: :model do
  it 'is valid' do
    commit = FactoryGirl.create(:commit)
    expect(commit).to be_valid
    end
end
