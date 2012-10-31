require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

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
  collection :contexts, :extend => EntityRepresenter
  property :rule

  link :self do
     "http://wally.redu.com.br/posts/1"
  end

  property :action
end

module WrappedPostRepresenter
  include Roar::Representer::JSON
  include PostRepresenter

  self.representation_wrap = true
end
