class Role
  include Mongoid::Document
  attr_accessor :thumbnails

  field :name
  field :thumbnail

  embedded_in :author

  def thumbnails
    {
      href: "teste",
      size: "16x16"
    }
  end
end
