FactoryGirl.define do
  factory :wall do
    sequence(:resource_id) { |n| "core:space_#{n}" }
  end
end
