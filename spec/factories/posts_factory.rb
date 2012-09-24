FactoryGirl.define do
  factory :post do
    created_at Date.today
    content({ text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do." })
    action "comment"
    rule({manage: true})
  end
end
