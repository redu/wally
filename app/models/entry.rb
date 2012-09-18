class Entry
  include Mongoid::Document

  field :created_at, type: DateTime
  field :content, type: Hash
  field :rule, type: Hash

  embeds_one :author
end
