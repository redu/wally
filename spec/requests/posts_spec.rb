require "spec_helper"

describe Grape::API do
  subject { Wally.new }

  def app; subject end

  # GET /posts/:id (get a Post)
  # POST /walls/:wall_id/posts (create a Post)
  # DELETE /posts/:id (delete a Post)
  before do
    @author = create(:author)
    @wall = create(:wall)
    @entity = create(:entity)
    @post = create(:post, author: @author, origin_wall: @wall.id,
                  target_on: @entity)
  end

  context "GET post by id" do
    context "when exist a post" do
      before do
        get "/posts/#{@post.id}"
      end

      it "should return the post" do
        parsed = parse(last_response.body)
        %w(id origin_wall target_on context action answers created_at author links).each do |attr|
          parsed.should have_key attr
        end
      end

      it "should return status 200" do
        last_response.status.should == 200
      end
    end

    context "when doesn't exist a post" do
      before do
        get "/posts/0"
      end

      it "should return empty body" do
        last_response.body.should == ""
      end

      it "should return status 404" do
        last_response.status.should == 404
      end
    end
  end

  context "DELETE post by id" do
    context "when exist a post" do
      it "should delete a Post" do
        expect {
          delete "/posts/#{@post.id}"
        }.to change(Post, :count).by(-1)
      end

      it "should return status 204" do
        delete "/posts/#{@post.id}"
        last_response.status.should == 204
      end

      it "should return empty body" do
        delete "/posts/#{@post.id}"
        last_response.body.should == ""
      end
    end

    context "when doesn't exist a post" do
      before do
        delete "/posts/0"
      end

      it "should return status 404" do
        last_response.status.should == 404
      end

      it "should return empty body" do
        last_response.body.should == ""
      end
    end
  end

  context "POST creating a post" do
    context "when the params is well formed" do
      before do
        @entity = create(:entity)
        @entity2 = create(:entity)
        @params = {
          post: {
            created_at: Date.today,
            content: { text: "Lorem Ipslum" },
            author: {
              user_id: @author.user_id,
              name: @author.name,
              thumbnails: [{ href: @author.thumbnails[:href],
                            size: @author.thumbnails[:size] }]
            },
            target_on: { entity_id: @entity.entity_id,
                         api_url: @entity.api_url,
                         core_url: @entity.core_url,
                         name: @entity.name },
            resource_id: @wall.resource_id,
            action: "comment",
            context: [{ entity_id: @entity.entity_id,
                        api_url: @entity.api_url,
                        core_url: @entity.core_url,
                        name: @entity.name },
                      { entity_id: @entity2.entity_id,
                        api_url: @entity2.api_url,
                        core_url: @entity2.core_url,
                        name: @entity2.name }
                     ]

          }
        }
      end

      it "should create a post" do
        expect {
          post "/posts", @params
        }.to change(Post, :count).by(1)
      end

      it "should return 201" do
        post "/posts", @params
        last_response.status.should == 201
      end

      it "should return all contexts" do
        post "/posts", @params
        Post.last.context.to_set.should == [@entity, @entity2].to_set
      end

      it "should return the target on" do
        post "/posts", @params
        Post.last.target_on.should == @entity
      end

      it "should return the author" do
        post "/posts", @params
        Post.last.author.should == @author
      end
    end

    context "when the params is well formed but contains semantic errors" do
      before do
        params = {
          post: {
            created_at: Date.today,
          }
        }
        post "/posts", params
      end

      it "should return 422 status" do
        last_response.status.should == 422
      end

      it "should show the errors" do
        parsed = parse(last_response.body)
        %w(content target_on origin_wall action).each do |attr|
          parsed.should have_key attr
        end
      end
    end
  end
end
