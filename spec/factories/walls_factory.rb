FactoryGirl.define do
  factory :wall do
    sequence(:resource_id) { |n| "core_space_#{n}" }
  end
end
