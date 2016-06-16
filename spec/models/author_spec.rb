require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'is valid' do
    author = FactoryGirl.create(:author)
    expect(author).to be_valid
  end

end
