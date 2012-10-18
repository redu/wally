require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'
require './app/representers/author_representer'

module AnswerRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :post_id
  property :created_at
  property :author, :extend => AuthorRepresenter
  property :content
  property :rule

  link :self do
    answer_url
  end
end

module WrappedAnswerRepresenter
  include Roar::Representer::JSON
  include AnswerRepresenter
  self.representation_wrap = true
end
