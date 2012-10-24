require "spec_helper"

describe AuthorObserver do
  before do
    @author_ob = AuthorObserver.send(:new)
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

  context "creating a author" do
    it "should create a Author" do
      expect {
        @author_ob.after_create(@params)
      }.to change(Author, :count).by(1)
    end

    it "should creates two Walls" do
      expect {
        @author_ob.after_create(@params)
      }.to change(Wall, :count).by(2)
    end
  end

  context "updating a author" do
    before do
      @author = create(:author, :user_id => 5678)
    end

    it "should update a user" do
      @author_ob.after_update(@params)
    end
  end
end
