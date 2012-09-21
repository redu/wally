class Wall
  include Mongoid::Document

  #Fields
  field :resource_id, type: String

  #Associations
  has_and_belongs_to_many :posts

  #Validations
  validates_presence_of :resource_id
  validates_uniqueness_of :resource_id

  #Callbacks
  after_destroy :destroy_posts

  def wall_path
    "http://wally.redu.com.br/walls/1"
  end

  private

  def destroy_posts
    self.posts.each do |post|
      if post.origin_wall == self.id
        post.destroy
      end
    end
  end
end
