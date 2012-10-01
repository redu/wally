class Author
  include Mongoid::Document
  attr_accessor :thumbnails

  field :user_id, type: Integer
  field :name, type: String
  field :login, type: String
  field :thumbnails, type: Hash
  field :perfil_url, type: String
  field :api_url, type: String

  embeds_one :role
  has_many :entries
end
