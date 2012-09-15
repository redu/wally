class Post
  include Mongoid::Document
  field: author, type: String
  field: content, type: String
end

