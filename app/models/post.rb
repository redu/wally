require "./app/models/entry"

class Post < Entry
  include Mongoid::Document

  field :origin_wall, type: Moped::BSON::ObjectId
  field :target_on, type: Hash
  field :context, type: Hash
  field :action, type: String

  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :walls
end

