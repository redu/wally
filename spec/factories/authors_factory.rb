FactoryGirl.define do
  factory :author do
    name "Rock Lee"
    login "rocklee"
    thumbnails({ address: "http://www.redu.com.br/images/rocklee.jpg",
                 size: "16x16"})
  end
end
