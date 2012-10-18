require "spec_helper"

describe Grape::API do
  subject { Wally.new }

  def app; subject end

  # Wall
  # GET /walls/:resource_id (get a Wall)
  # GET /walls/?resource_id=:resource_id (get all Walls of a
  before do
    @wall = create(:wall)
    @author = create(:author)
  end

  context "GET wall by resource_id" do
    context "when exist a wall" do
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

        get("/walls/#{@wall.resource_id}", {}, {"Authorization" =>  "OAuth #{@author.token}"})
      end

      it "should return the wall" do
        parsed = parse(last_response.body)
        parsed.should have_key "wall"
        %w(resource_id posts links).each do |attr|
          parsed["wall"].should have_key attr
        end
      end

      it "should return status 200" do
        last_response.status.should == 200
      end
    end

    context "when token isn't passed trough header" do
      before do
        get "walls/0", {}
      end

      it "should return miss header body" do
        last_response.body.should == "Missing parameter Authorization in header."
      end

      it "should return status 401" do
        last_response.status.should == 401
      end
    end

    context "when author doesn't have access(via permit) to the resource" do
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

        get "walls/#{@wall.resource_id}", {}, {"Authorization" =>  "OAuth #{@author.token}"}

      end

      it "should return unauthorized body" do
        last_response.body.should == "401 Unauthorized - You don't have access to this resource or your token doesn't exist"
      end

      it "should return status 401" do
        last_response.status.should == 401
      end
    end

    context "when doesn't exist a wall" do
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

        get "/walls/0", {}, {"Authorization" =>  "OAuth #{@author.token}"}
      end

      it "should return empty body" do
        last_response.body.should == ""
      end

      it "should return status 404" do
        last_response.status.should == 404
      end
    end

    context "send a notification to permit" do
      before do
        class Wally < Grape::API
          helpers do
            def current_ability
              @current_ability ||= Ability.new(current_user)
            end
          end
        end

        WebMock.disable_net_connect!
        @url = "http://permit.redu.com.br/rules"
        stub_request(:get, @url).
          with(:query => {resource_id: @wall.resource_id,
                          subject_id: @author.subject_permit},
               :headers => {'accept'=>'application/json',
                            'expect'=>''}).
          to_return(:status => 200, :body => [{resource_id:@wall.resource_id, subject_id:@author.subject_permit,
                                              actions: {read:true} }].to_json, :headers => {})
        get "walls/#{@wall.resource_id}", {}, {"Authorization" =>  "OAuth #{@author.token}"}

      end

      it "should send a notification to permit" do
        a_request(:get, @url).
          with(:query => {resource_id: @wall.resource_id,
                          subject_id: @author.subject_permit},
               :headers => {'accept'=>'application/json',
                            'expect'=>''}).should have_been_made
      end
    end
  end
end
