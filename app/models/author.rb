class Author
  include Mongoid::Document
  attr_accessor :thumbnails

  field :name, type: String
  field :login, type: String
  field :thumbnails, type: Hash

  embeds_one :role
  embedded_in :entry

  def home_url
    "http://www.redu.com.br/pesssoas/#{self.login}"
  end

  def api_url
    "http://www.redu.com.br/api/users/#{self.login}"
  end

end
