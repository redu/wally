FactoryGirl.define do
  factory :answer do
    created_at Date.today
    content({ text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do." })
    rule({manage: true})
  end
end
