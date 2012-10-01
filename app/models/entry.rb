require "mongoid"

class Entry
  include Mongoid::Document

  field :created_at, type: DateTime
  field :content, type: Hash
  field :rule, type: Hash

  belongs_to :author

  validates_presence_of :created_at
  validates_presence_of :content
  validates_presence_of :author
end
