# -*- encoding : utf-8 -*-
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module PostRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :p_id, :from => :id
  property :origin_wall
  property :created_at
  property :content
  property :target_on, :extend => EntityRepresenter
  property :author, :extend => AuthorRepresenter
  property :rule
  property :action
  collection :answers, :extend => AnswerRepresenter
  collection :contexts, :extend => EntityRepresenter

  link :self do
     "http://wally.redu.com.br/posts/1"
  end

  def p_id
    id.to_s
  end
end

module WrappedPostRepresenter
  include Roar::Representer::JSON
  include PostRepresenter

  self.representation_wrap = true
end

