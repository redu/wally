class Author
  include Mongoid::Document
  attr_accessor :thumbnails

  field :name, type: String
  field :login, type: String
  field :thumbnail, type: String

  embedded_in :entry
  embeds_one :role

  def home_url
    "http://www.redu.com.br/pesssoas/#{self.login}"
  end

  def api_url
    "http://www.redu.com.br/api/users/#{self.login}"
  end

  def thumbnails
    [{href: self.thumbnail, size: "32x32"}]
  end
end
