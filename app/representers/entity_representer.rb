require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module EntityRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :entity_id

  link :self do
    api_url
  end

  link :public_self do
    core_url
  end
end
