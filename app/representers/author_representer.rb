require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'
require './app/representers/role_representer'

module AuthorRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :login
  property :user_id
  property :role, :extend => RoleRepresenter

  collection :thumbnails

  link :public_self do
    api_url
  end

  link :self do
    perfil_url
  end
end
