class Entity
  include Mongoid::Document

  field :name, type: String
  field :entity_id, type: Integer
  field :api_url, type: String
  field :core_url, type: String

  validates_presence_of :name, :entity_id, :api_url, :core_url
  validates_uniqueness_of :entity_id

  has_many :target_on_posts, class_name: "Post",
    inverse_of: :target_on

  has_and_belongs_to_many :context_posts, class_name: "Post",
    inverse_of: :contexts
end
