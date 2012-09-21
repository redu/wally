require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module AuthorRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :thumbnails
  property :role, :extend => RoleRepresenter

  link :public_self do
    api_url
  end

  link :self do
    perfil_url
  end
end
