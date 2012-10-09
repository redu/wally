FactoryGirl.define do
  factory :author do
    name "Rock Lee"
    login "rocklee"
    thumbnails({ href: "http://www.redu.com.br/images/rocklee.jpg",
                 size: "16x16"})
    perfil_url "http://redu.com.br/pessoas/rocklee"
    api_url "http://redu.com.br/api/users/rocklee"
    sequence(:user_id) {|n| n }
    sequence(:token) { |n| "#{n}" }
  end
end
