require "./app/models/entry"

class Post < Entry
  include Mongoid::Document

  field :action, type: String

  belongs_to :origin_wall, class_name: "Wall",
    inverse_of: :original_posts
  belongs_to :target_on, class_name: "Entity",
    inverse_of: :target_on_posts
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :context, class_name: "Entity",
    inverse_of: :context_posts

  validates_presence_of(:target_on)
  validates_presence_of(:origin_wall)
  validates_presence_of(:action)

  def self.fill_and_build(params)
    post = Post.new
    post.created_at = params[:created_at]
    post.content = params[:content]
    post.origin_wall = Wall.find_by(resource_id: params[:resource_id])
    post.author = Author.find_by(user_id: params[:author].try(:user_id))
    post.target_on = Entity.find_by(entity_id: params[:target_on].try(:entity_id))
    post.action = params[:action]
    if params[:context]
      params[:context].each do |con|
        post.context << Entity.find_by(entity_id: con.try(:entity_id))
      end
    end
    post
  end
end

