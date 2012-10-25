#Answer
# GET /answers/:id (get an Answer)
# POST /posts/:post_id/answers (create an Answer)
# DELETE /answers/:id (delete an Answer)
class Wally < Grape::API
  format :json
  before do
    header "Access-Control-Allow-Origin", "*"
  end

  resource :answers do
    get ':id' do
      header "Access-Control-Allow-Origin", "*"
      answer = Answer.find(params[:id])
      if answer
        authorize!(answer.post.origin_wall.resource_id)
        answer.define_rule(current_ability, current_user)
        answer.extend(WrappedAnswerRepresenter)
        answer.to_json
      else
        status 404
        ""
      end
    end

    params do
      group :answer do
        requires :post_id
      end
    end
    post do
      header "Access-Control-Allow-Origin", "*"
      post = Post.find(params[:answer][:post_id])
      authorize!(post.origin_wall.resource_id)
      answer = Answer.fill_and_build(params[:answer])
      if answer.save
        status 201
        answer.define_rule(current_ability, current_user)
        answer.extend(WrappedAnswerRepresenter)
        answer.to_json
      else
        status 422
        answer.errors
      end
    end

    delete ':id' do
      header "Access-Control-Allow-Origin", "*"
      answer = Answer.find(params[:id])
      if answer
        authorize!(answer.post.origin_wall.resource_id)
        answer.destroy
        status 204
        ""
      else
        status 404
        ""
      end
    end
  end
end
