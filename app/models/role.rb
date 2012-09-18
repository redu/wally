class Role
  include Mongoid::Document

  field :name, type: String
  field :thumbnail, type: Hash

  embedded_in :author
end
