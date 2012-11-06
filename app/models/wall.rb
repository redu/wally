# -*- encoding : utf-8 -*-
class Wall
  include Mongoid::Document

  #Fields
  field :resource_id, type: String

  #Associations
  has_many :original_posts, class_name: "Post", inverse_of: :origin_wall
  has_and_belongs_to_many :posts

  #Self-referencing
  has_and_belongs_to_many :reference_walls, class_name: "Wall",
    inverse_of: :walls
  has_and_belongs_to_many :walls, class_name: "Wall",
    inverse_of: :reference_walls

  #Validations
  validates_presence_of :resource_id
  validates_uniqueness_of :resource_id

  #Callbacks
  after_destroy :destroy_posts

  def wall_path
    "http://wally.redu.com.br/walls/#{self.id}"
  end

  def define_rule(ability, current_user)
    self.posts.each do |post|
      post.define_rule(ability, current_user)
    end
  end

  private

  def destroy_posts
    self.posts.each do |post|
      if post.origin_wall == self
        post.destroy
      end
    end
  end
end

