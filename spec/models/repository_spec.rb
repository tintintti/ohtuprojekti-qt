require 'rails_helper'

RSpec.describe Repository, type: :model do
  it 'is valid' do
    repository = FactoryGirl.create(:repository)
    expect(repository).to be_valid
    end
end
