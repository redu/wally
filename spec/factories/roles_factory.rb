FactoryGirl.define do
  factory :role do
    name "tutor"
    thumbnail({ address: "http://www.redu.com.br/images/tutor.jpg",
                size: "16x16"})
    author
  end
end
