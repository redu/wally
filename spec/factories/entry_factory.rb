FactoryGirl.define do
  factory :entry do
    created_at Date.today
    content({ text: "Lorem ipsum dolor sit amet." })
    author
  end
end

