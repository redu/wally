# -*- encoding : utf-8 -*-
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module AuthorRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :a_id, :from => :id
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

  def a_id
    id.to_s
  end
end

