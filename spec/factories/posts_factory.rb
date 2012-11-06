# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :post do
    created_at DateTime.now
    content({ text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do." })
    action "comment"
  end
end

