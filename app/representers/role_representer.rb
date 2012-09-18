require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module RoleRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :name
  property :thumbnails

end
