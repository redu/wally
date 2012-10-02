require "spec_helper"

describe Grape::API do
  subject { Wally.new }

  def app; subject end

  # Wall
  # GET /walls/:resource_id (get a Wall)
  # GET /walls/?resource_id=:resource_id (get all Walls of a
  before do
    @wall = create(:wall)
  end

  context "GET wall by resource_id" do
    context "when exist a wall" do
      before do
        get "/walls/#{@wall.resource_id}"
      end

      it "should return the wall" do
        parsed = parse(last_response.body)
        %w(id resource_id posts).each do |attr|
          parsed.should have_key attr
        end
      end

      it "should return status 200" do
        last_response.status.should == 200
      end
    end

    context "when doesn't exist a wall" do
      before do
        get "/walls/0"
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
