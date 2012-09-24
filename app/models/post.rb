require "./app/models/entry"

class Post < Entry
  include Mongoid::Document

  field :origin_wall, type: Moped::BSON::ObjectId
  field :owner_id, type: Integer
  field :target_on, type: Hash
  field :action, type: String

  belongs_to :target_on, class_name: "Entity",
    inverse_of: :target_on_posts
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :contexts, class_name: "Entity",
    inverse_of: :context_posts
end

