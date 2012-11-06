# -*- encoding : utf-8 -*-
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module AnswerRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :a_id, :from => :id
  property :p_id, :from => :post_id
  property :created_at
  property :author, :extend => AuthorRepresenter
  property :content
  property :rule

  link :self do
    answer_url
  end

  def a_id
    id.to_s
  end

  def p_id
    post_id.to_s
  end
end

module WrappedAnswerRepresenter
  include Roar::Representer::JSON
  include AnswerRepresenter
  self.representation_wrap = true
end

