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
        Wally.class_variable_set(:@@double, double("Permit::Mechanism"))
        class Wally < Grape::API
          helpers do
            def permit
              permit = @@double
              permit.stub(:able_to?).and_return(true)
              permit
            end
          end
        end

        get "/walls/#{@wall.resource_id}", {token: @author.token}
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

    context "when token isn't passed trough params" do
      before do
        get "walls/0"
      end

      it "should return miss parameter body" do
        last_response.body.should == "missing parameter: token"
      end

      it "should return status 400" do
        last_response.status.should == 400
      end
    end

    context "when author doesn't have access(via permit) to the resource" do
      before do
        Wally.class_variable_set(:@@double, double("Permit::Mechanism"))
        class Wally < Grape::API
          helpers do
            def permit
              permit = @@double
              permit.stub(:able_to?).and_return(false)
              permit
            end
          end
        end

        get "walls/#{@wall.resource_id}", {token: @author.token}
      end

      it "should return unauthorized body" do
        last_response.body.should == "401 Unauthorized"
      end

      it "should return status 401" do
        last_response.status.should == 401
      end
    end

    context "when doesn't exist a wall" do
      before do
        Wally.class_variable_set(:@@double, double("Permit::Mechanism"))
        class Wally < Grape::API
          helpers do
            def permit
              permit = @@double
              permit.stub(:able_to?).and_return(true)
              permit
            end
          end
        end

        get "/walls/0", {token: @author.token}
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
        Wally.class_variable_set(:@@double, double("Permit::Mechanism"))
        class Wally < Grape::API
          helpers do
            def permit
              @permit ||= Permit::Mechanism.new(:subject_id => current_user.subject_permit, :service_name => "wally")
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
        get "walls/#{@wall.resource_id}", {token: @author.token}
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
