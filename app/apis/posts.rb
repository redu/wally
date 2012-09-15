# Post
class Wally < Grape::API
  format :json

  namespace "/walls/:wall_id" do
    # GET /walls/:wall_id/posts (get a list of Posts)
    resource :posts do
      get do
        puts Wally::routes
        Post.create(:author => "Tiago", :content => "Está pegando")
        {:teste => "Teste"}
      end

      # POST /walls/:wall_id/posts (create a Post)
      post do
      end
    end
  end

  resource :posts do
    # GET /posts/:id (get a Post)
    get ':id' do
    end

    # DELETE /posts/:id (delete a Post)
    delete ':id' do
    end
  end
end
