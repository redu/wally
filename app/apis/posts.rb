require "./app/models/post"
require "./app/representers/post_representer"
require "./app/representers/answer_representer"

# Post
class Wally < Grape::API
  format :json

  resource :posts do
    post do
      post = Post.fill_and_build(params[:post])
      if post.save
        status 201
        post
      else
        status 422
        post.errors
      end
    end

    # GET /posts/:id (get a Post)
    get ':id' do
      post = Post.find(params[:id])
      if post
        post.extend(PostRepresenter)
        post.to_json
      else
        status 404
        ""
      end
    end

    # DELETE /posts/:id (delete a Post)
    delete ':id' do
      post = Post.find(params[:id])
      if post
        post.destroy
        status 204
        ""
      else
        status 404
        ""
      end
    end
  end
end
