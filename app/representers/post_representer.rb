require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'
require './app/representers/entity_representer'
require './app/representers/author_representer'
require './app/representers/answer_representer'

module PostRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :origin_wall
  property :created_at
  property :content
  property :target_on, :extend => EntityRepresenter
  property :author, :extend => AuthorRepresenter
  collection :answers, :extend => AnswerRepresenter
  collection :context, :extend => EntityRepresenter

  link :self do
     "http://wally.redu.com.br/posts/1"
  end

  property :action
  property :rule
end
