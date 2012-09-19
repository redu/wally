class Post < Entry
  include Mongoid::Document

  field :wall_id, type: Integer
  field :target_on, type: Hash
  field :context, type: Hash
  field :action, type: String

  has_many :answers, dependent: :destroy
end

