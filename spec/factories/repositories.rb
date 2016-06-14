FactoryGirl.define do

  factory :repository do
    sequence(:name) { |n| "reposirory #{n}" }
  end

end
