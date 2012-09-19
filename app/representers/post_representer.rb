require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module PostRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :wall_id
  property :created_at
  property :author, :extend => AuthorRepresenter
  collection :answers
  property :content

  link :self do
     "http://wally.redu.com.br/posts/1"
  end

  property :action
  property :rule


end
