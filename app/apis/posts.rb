# Post
class Wally < Grape::API
  format :json
  before do
    header "Access-Control-Allow-Origin", "*"
  end

  resource :posts do
    # GET /posts/:id (get a Post)
    get ':id' do
      header "Access-Control-Allow-Origin", "*"
      post = Post.find(params[:id])
      if post
        authorize!(post.origin_wall.resource_id)
        post.define_rule(current_ability, current_user)
        post.extend(WrappedPostRepresenter)
        post.to_json
      else
        status 404
        ""
      end
    end

    post do
      header "Access-Control-Allow-Origin", "*"
      authorize!(params[:post][:origin_wall])
      post = Post.fill_and_build(params[:post])
      if post.save
        status 201
        post.define_rule(current_ability, current_user)
        post.extend(WrappedPostRepresenter)
        post.to_json
      else
        status 422
        post.errors
      end
    end

    # DELETE /posts/:id (delete a Post)
    delete ':id' do
      header "Access-Control-Allow-Origin", "*"
      post = Post.find(params[:id])
      if post
        authorize!(post.origin_wall.resource_id)
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
