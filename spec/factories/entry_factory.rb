# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :entry do
    created_at DateTime.now
    content({ text: "Lorem ipsum dolor sit amet." })
    author
  end
end


