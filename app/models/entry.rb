class Entry
  include Mongoid::Document

  field :created_at, type: DateTime
  field :content, type: Hash

  belongs_to :author

  validates_presence_of :created_at
  validates_presence_of :content
  validates_presence_of :author
  validate :validate_content

  def validate_content
    unless content && content.has_key?(:text) && !content[:text].blank?
      errors.add(:content, "text cann't be blank")
    end
  end
end
