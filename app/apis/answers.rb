require "./app/models/post"
require "./app/models/answer"
require "./app/representers/answer_representer"
require "debugger"

#Answer
# GET /answers/:id (get an Answer)
# POST /posts/:post_id/answers (create an Answer)
# DELETE /answers/:id (delete an Answer)
class Wally < Grape::API
  format :json

  resource :answers do
    get ':id' do
      answer = Answer.find(params[:id])
      if answer
        answer.extend(AnswerRepresenter)
        status 200
        answer.to_json
      else
        status 404
        ""
      end
    end

    post do
      answer = Answer.fill_and_build(params[:answer])
      if answer.save
        status 201
        answer
      else
        status 422
        answer.errors
      end
    end

    delete ':id' do
      answer = Answer.find(params[:id])
      if answer
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
