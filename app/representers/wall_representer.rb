# -*- encoding : utf-8 -*-
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module WallRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia
  self.representation_wrap = true

  property :resource_id
  collection :posts, :extend => PostRepresenter

  link :self do
    wall_path
  end
end

