require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module EntityRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :e_id, :from => :id
  property :name
  property :entity_id

  link :self do
    api_url
  end

  link :public_self do
    core_url
  end

  def e_id
    id.to_s
  end
end
