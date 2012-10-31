class Post < Entry
  attr_reader :rule
  include Mongoid::Document

  field :action, type: String

  belongs_to :origin_wall, class_name: "Wall", foreign_key: "resource_id",
    inverse_of: :original_posts
  belongs_to :target_on, class_name: "Entity",
    inverse_of: :target_on_posts
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :contexts, class_name: "Entity",
    inverse_of: :contexts_posts

  validates_presence_of(:target_on)
  validates_presence_of(:origin_wall)
  validates_presence_of(:action)

  def self.fill_and_build(params)
    post = Post.new
    post.created_at = DateTime.now
    post.content = params[:content]
    wall = Wall.find_by(resource_id: params[:origin_wall])
    post.origin_wall = wall
    post.walls << wall
    post.author = Author.find_by(user_id: params[:author].try(:user_id))
    post.target_on = Entity.find_by(entity_id: params[:target_on].try(:entity_id))
    post.action = params[:action]
    if params[:contexts]
      params[:contexts].each do |con|
        post.contexts << Entity.find_by(entity_id: con.try(:entity_id))
      end
    end
    post
  end

  def define_rule(ability, current_user)
    resource = self.origin_wall.resource_id
    @rule ||= if self.author == current_user
                { :manage => true }
              else
                if ability.can?(:manage, resource)
                  { :manage => true }
                else
                  { }
                end
              end

    self.answers.each { |a| a.define_rule(ability, current_user) }
  end
end
