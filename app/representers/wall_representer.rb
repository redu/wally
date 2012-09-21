require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module WallRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :resource_id
  collection :posts

  link :self do
    wall_path
  end
end
