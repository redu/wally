FactoryGirl.define do
  factory :answer do
    created_at DateTime.now
    content({ text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do." })
  end
end
