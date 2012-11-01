require "spec_helper"
require "untied-consumer"

describe UserObserver do
  before do
    @user_ob = UserObserver.send(:new)
    @params = { "user" => {
      "created_at" => "2012-10-23T09:50:38-02:00",
      "birthday" => "1999-10-23T09:50:34-02:00",
      "updated_at" => "2012-10-23T09:50:38-02:00",
      "role" => 2,
      "removed" => false,
      "oauth_token" => nil,
      "single_access_token" => "miAgtAxiYD13ni42ZM4z",
      "email" => "usuario3@redu.com",
      "first_name" => "Usuario 3",
      "oauth_secret" => nil,
      "login" => "usuario3",
      "id" => 5678,
      "perishable_token" => "dtA9QBM2QxW4SGBty2V",
      "last_name" => "da Silva 3"
      }
    }
  end

  context "creating an author" do
    it "should create an Author" do
      expect {
        @user_ob.after_create(@params)
      }.to change(Author, :count).by(1)
    end

    it "should creates two Walls" do
      expect {
        @user_ob.after_create(@params)
      }.to change(Wall, :count).by(2)
    end

    it "should create an Entity" do
      expect {
        @user_ob.after_create(@params)
      }.to change(Entity, :count).by(1)
    end
  end

  context "updating an author" do
    before do
      @author = create(:author, user_id: @params["user"]["id"])
    end

    it "should update an author" do
      @user_ob.after_update(@params)
      @author.reload
      @author.login.should == @params["user"]["login"]
    end
  end
end
