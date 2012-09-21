require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module PostRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :origin_wall
  property :created_at
  property :author, :extend => AuthorRepresenter
  collection :answers, :extend => AnswerRepresenter
  property :content

  link :self do
     "http://wally.redu.com.br/posts/1"
  end

  property :action
  property :rule
end
