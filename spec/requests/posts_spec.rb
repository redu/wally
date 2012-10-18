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
  let(:authorized) { {"Authorization" => "OAuth #{@author.token}"} }
  let(:not_authorized) { {"Authorization" => "OAuth 0"} }

  describe "GET post by id" do
    context "when is authorized" do
      before do
        Wally.class_variable_set(:@@double, double("Ability"))
        class Wally < Grape::API
          helpers do
            def current_ability
              ability = @@double
              ability.stub(:can?).and_return(true)
              ability
            end
          end
        end
      end

      context "when exist a post" do
        before do
          get "/posts/#{@post.id}", {}, authorized
        end

        it "should return the post" do
          parsed = parse(last_response.body)
          parsed.should have_key "post"
          %w(id origin_wall target_on contexts action answers created_at author links).each do |attr|
            parsed['post'].should have_key attr
          end
        end

        it "should return status 200" do
          last_response.status.should == 200
        end
      end

      context "when doesn't exist a post" do
        before do
          get "/posts/0", {}, authorized
        end

        it "should return empty body" do
          last_response.body.should == ""
        end

        it "should return status 404" do
          last_response.status.should == 404
        end
      end
    end

    describe "when isn't authorized (401) because token doesn't exist" do
      before do
        Wally.class_variable_set(:@@double, double("Ability"))
        class Wally < Grape::API
          helpers do
            def current_ability
              ability = @@double
              ability.stub(:can?).and_return(true)
              ability
            end
          end
        end

        get "/posts/#{@post.id}", {}, not_authorized
      end

      it "should return 401 (unauthorized)" do
        last_response.status.should == 401
      end

      it "should return unauthorized body" do
        last_response.body.should == "401 Unauthorized - You don't have access to this resource or your token doesn't exist"
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
            created_at: DateTime.now,
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

  describe "DELETE post by id" do
    context "when is authorized" do
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

    context "when isn't authorized" do
      context "whithout authorization header" do
        before do
          delete "/posts/#{@post.id}"
        end

        it "should return 401 status" do
          last_response.status.should == 401
        end

        it "should return not authorized body" do
          last_response.body.should == "Missing parameter Authorization in header."
        end
      end

      context "whithout permit access" do
        before do
          Wally.class_variable_set(:@@double, double("Ability"))
          class Wally < Grape::API
            helpers do
              def current_ability
                ability = @@double
                ability.stub(:can?).and_return(false)
                ability
              end
            end
          end

          delete "/posts/#{@post.id}", {}, authorized
        end

        it "should return 401 status" do
          last_response.status.should == 401
        end

        it "should return not authorized body" do
          last_response.body.should == "401 Unauthorized - You don't have access to this resource or your token doesn't exist"
        end
      end
    end
  end


end
