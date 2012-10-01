require "spec_helper"

describe Grape::API do
  subject { Wally.new }
  def app; subject end

  before do
    author = create(:author)
    @wall = create(:wall)
    entity = create(:entity)
    @post = create(:post, author: author,
                   origin_wall: @wall.id, target_on: entity)
    @answer = create(:answer, post_id: @post.id,
                     author: create(:author))
  end

  context "GET answer by id" do
    context "when exist an answer" do
      before do
        get "/answers/#{@answer.id}"
      end

      it "should return the answer" do
        parsed = parse(last_response.body)
        %w(id post_id created_at author content links).each do |attr|
          parsed.should have_key attr
        end
      end

      it "should return status 200" do
        last_response.status.should == 200
      end
    end

    context "when doesn't exist an answer" do
      before do
        get "/answers/0"
      end

      it "should return 404(not found)" do
        last_response.status.should == 404
      end

      it "should return empty body" do
        last_response.body.should == ""
      end
    end
  end

  context "POST creating an answer" do
    context "when the params is well formatted" do
      before do
        author = create(:author)
        @params = {
          answer: {
            post_id: @post.id,
            created_at: "2011-02-06T08:50:14-02:00",
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
          post "/answers", @params
        }.to change(Answer, :count).by(1)
      end

      it "should return 201" do
        post "/answers", @params
        last_response.status.should == 201
      end
    end

    context "when the params isn't well formatted" do
      before do
        @params = {
          answer: {
            post_id: 1,
          }
        }
        post "/answers", @params
      end

      it "should return 422 bad request" do
        last_response.status.should == 422
      end

      it "should return the errors" do
        parsed = parse(last_response.body)
        %w(post created_at author content).each do |attr|
          parsed.should have_key attr
        end
      end
    end
  end

  context "DELETE an answer by id" do
    context "when exist an answer" do
     it "should delete an answer" do
        expect {
          delete "/answers/#{@answer.id}"
        }.to change(Answer, :count).by(-1)
      end

      it "should return empty body" do
        delete "/answers/#{@answer.id}"
        last_response.body.should == ""
      end

      it "should return status 204" do
        delete "/answers/#{@answer.id}"
        last_response.status.should == 204
      end
    end

    context "when doesn't exist an answer" do
      before do
        delete "/answers/0"
      end

      it "should return empty body" do
        last_response.body.should == ""
      end

      it "should return status 404" do
        last_response.status.should == 404
      end
    end
  end
end
