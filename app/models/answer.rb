# -*- encoding : utf-8 -*-
class Answer < Entry
  attr_reader :rule

  belongs_to :post

  validates_presence_of :post

  def define_rule(ability, current_user)
    resource = self.post.origin_wall.resource_id

    @rule ||= if self.author == current_user
                { :manage => true }
              else
                if ability.can?(:manage, resource)
                  { :manage => true }
                else
                  { }
                end
              end
  end

  def answer_url
    "http://wally.redu.com.br/answers/#{self.id}"
  end

  # fill the params that came from controller and build a answer entity
  def self.fill_and_build(params)
    answer = Answer.new
    answer.created_at = DateTime.now
    answer.content = params[:content]
    answer.post = Post.find(params[:post_id])
    answer.author =
      Author.find_by(user_id: params[:author].try(:user_id))
    answer
  end
end

