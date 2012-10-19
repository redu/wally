require "spec_helper"

describe Grape::API do
  subject { Wally.new }

  def app; subject end

  # Wally
  # GET /:resource_id (get an Wally Initialization)
  before do
    @wall = create(:wall)
    @author = create(:author)
  end

  context "GET wall by resource_id" do
    before do
      params = {
        user: { links: [{ href: "http://0.0.0.0:3000/pessoas/julianalucena",
                          rel: "public_self" }],
                name: "Juliana Lucena",
                thumbnails: [{ href: "http://0.0.0.0:3000//images/new/missing_users_thumb_32.png",
                               size:"32x32" }],
                user_id: "8" },
        target: { entity_id: "445", kind: "space",
                  links: [{ href: "http://0.0.0.0:3000/espacos/445",
                            rel: "self_public" }],
                  name: "Processos de desenvolvimento" },
        contexts: [{ entity_id: "351",
                     links: [{ href: "http://0.0.0.0:3000/redu-educational-technologies",
                               rel: "self_public"}],
                     name: "Redu Educational Technologies"},
                   { entity_id: "387",
                     links: [{ href: "http://0.0.0.0:3000/redu-educational-technologies/cursos/desenvolvimento",
                               rel: "self_public"}],
                     name: "Desenvolvimento"}]
      }
      get("/#{@wall.resource_id}", params, {"Authorization" =>  "OAuth #{@author.token}"})
    end

    it "should return status 200" do
      last_response.status.should == 200
    end

    it "should return text/html as Content-Type" do
      last_response.original_headers["Content-Type"].should include("text/html")
    end

    it "should return UTF-8 as charset" do
      last_response.original_headers["Content-Type"].should include("charset=UTF-8")
    end

    it "should return a html page that includes params informations" do
      last_response.body.should include("Juliana Lucena")
      last_response.body.should include("Processos de desenvolvimento")
      last_response.body.should include("Redu Educational Technologies")
      last_response.body.should include("Desenvolvimento")
    end
  end
end
