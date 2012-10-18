class Author
  include Mongoid::Document
  attr_accessor :thumbnails

  field :user_id, type: Integer
  field :name, type: String
  field :login, type: String
  field :thumbnails, type: Array
  field :perfil_url, type: String
  field :api_url, type: String
  field :token, type: String

  embeds_one :role
  has_many :entries

  validates_presence_of(:user_id)
  validates_presence_of(:token)
  validates_uniqueness_of(:user_id)
  validates_uniqueness_of(:token)

  def subject_permit
    "core:users_#{self.user_id}"
  end
end
