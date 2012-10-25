class Author
  include Mongoid::Document
  attr_accessor :thumbnails

  field :user_id, type: Integer
  field :name, type: String
  field :login, type: String
  field :thumbnails, type: Array
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

  def api_url
    "http://www.redu.com.br/api/users/#{self.user_id}"
  end

  def perfil_url
    "http://www.redu.com.br/pessoas/#{self.login}"
  end
end
