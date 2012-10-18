require "spec_helper"

describe Grape::API do
  subject { Wally.new }
  def app; subject end

  before do
    @author = create(:author)
    @wall = create(:wall)
    entity = create(:entity)
    @post = create(:post, author: @author,
                   origin_wall: @wall.id, target_on: entity)
    @answer = create(:answer, post_id: @post.id,
                     author: create(:author))
  end
  let(:authorized) { {"Authorization" => "OAuth #{@author.token}"} }
  let(:not_authorized) { {"Authorization" => "OAuth 0"} }

  context "GET answer by id" do
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
      context "when exist an answer" do
        before do
          get "/answers/#{@answer.id}", {}, authorized
        end

        it "should return the answer" do
          parsed = parse(last_response.body)
          parsed.should have_key "answer"
          %w(id post_id created_at author content links rule).each do |attr|
            parsed["answer"].should have_key attr
          end
        end

        it "should return status 200" do
          last_response.status.should == 200
        end
      end

      context "when doesn't exist an answer" do
        before do
          get "/answers/0", {}, authorized
        end

        it "should return 404(not found)" do
          last_response.status.should == 404
        end

        it "should return empty body" do
          last_response.body.should == ""
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

        get "/answers/#{@answer.id}", {}, not_authorized
      end

      it "should return 401 (unauthorized)" do
        last_response.status.should == 401
      end

      it "should return unauthorized body" do
        last_response.body.should == "401 Unauthorized - You don't have access to this resource or your token doesn't exist"
      end
    end
  end

  context "POST creating an answer" do
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

    context "when is authorized" do
      context "when the params is well formatted" do
        before do
          author = create(:author)
          @params = {
            answer: {
            post_id: @post.id,
            author: {
            user_id: author.user_id,
            name: author.name,
            thumbnails: [{ href: author.thumbnails[:href],
                           size: author.thumbnails[:size] }]
            },
            content: {text: "Lorem ipsum"}
            }
          }
        end

        it "should create an answer" do
          expect {
            post "/answers", @params, authorized
          }.to change(Answer, :count).by(1)
        end

        it "should return 201" do
          post "/answers", @params, authorized
          last_response.status.should == 201
        end
      end

      context "when the post_id isn't passed" do
        before do
          @params = {
            answer: {}
          }
          post "/answers", @params, authorized
        end

        it "should return 400" do
          last_response.status.should == 400
        end

        it "should return the post_id error" do
          last_response.body.should == "missing parameter: post_id"
        end
      end

      context "when the params isn't well formatted" do
        before do
          @params = {
            answer: {
              post_id: @post.id,
            }
          }
          post "/answers", @params, authorized
        end

        it "should return 422 bad request" do
          last_response.status.should == 422
        end

        it "should return the errors" do
          parsed = parse(last_response.body)
          %w(author content).each do |attr|
            parsed.should have_key attr
          end
        end
      end
    end

    context "when isn't authorized" do
      before do
        author = create(:author)
        @params = {
          answer: {
          post_id: @post.id,
          author: {
          user_id: author.user_id,
          name: author.name,
          thumbnails: [{ href: author.thumbnails[:href],
                         size: author.thumbnails[:size] }]
          },
          content: {text: "Lorem ipsum"}
          }
        }
      end

      context "whithout authorization header" do
        before do
          post "/answers", @params
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

          post "/answers", @params, authorized
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

  context "DELETE an answer by id" do
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
      context "when exist an answer" do
        it "should delete an answer" do
          expect {
            delete "/answers/#{@answer.id}", {}, authorized
          }.to change(Answer, :count).by(-1)
        end

        it "should return empty body" do
          delete "/answers/#{@answer.id}", {}, authorized
          last_response.body.should == ""
        end

        it "should return status 204" do
          delete "/answers/#{@answer.id}", {}, authorized
          last_response.status.should == 204
        end
      end

      context "when doesn't exist an answer" do
        before do
          delete "/answers/0", {}, authorized
        end

        it "should return empty body" do
          last_response.body.should == ""
        end

        it "should return status 404" do
          last_response.status.should == 404
        end
      end
    end

    context "when isn't authorized" do
      context "whithout authorization header" do
        before do
          delete "/answers/#{@answer.id}"
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

          delete "/answers/#{@answer.id}", {}, authorized
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
