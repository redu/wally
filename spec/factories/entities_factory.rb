FactoryGirl.define do
  factory :entity do
    sequence(:name) { |n| "Curso #{n}" }
    sequence(:entity_id) { |n| n }
    api_url "http://www.redu.com.br/"
    core_url "http://www.redu.com.br"
  end
end
