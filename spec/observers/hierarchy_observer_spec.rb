require "spec_helper"

describe HierarchyObserver do
  before do
    @hierarchy_ob = HierarchyObserver.send(:new)
  end

  context "space" do

    before do
      @params = {
        "space"=>
        {"description" => "Disciplina sobre como aplicar Reiki em seu dia-a-dia.",
         "published" => true,
         "destroy_soon" => false,
         "avatar_file_name" => nil,
         "user_id" => 5790,
         "name" => "Reiki",
         "id" => 1590,
         "updated_at" => "2012-10-30T11:56:37-02:00",
         "avatar_updated_at" => nil,
         "avatar_file_size" => nil,
         "avatar_content_type" => nil,
         "removed" => false,
         "members_count" => 0,
         "created_at" => "2012-10-25T18:09:36-02:00",
         "course_id" => 1101}
      }
    end

    context "creating a space in core" do
      it "should create an Entity" do
        expect {
          @hierarchy_ob.after_create(@params)
        }.to change(Entity, :count).by(1)
      end

      context "when wall space already exists" do
        before do
          create(:wall, resource_id: "core:space_#{@params["space"]["id"]}" )
        end

        it "should do nothing" do
          expect {
            @hierarchy_ob.after_create(@params)
          }.to change(Wall, :count).by(0)
        end
      end

      context "when wall space doesn't exists" do
        it "should create a wall" do
          expect {
            @hierarchy_ob.after_create(@params)
          }.to change(Wall, :count).by(1)
        end
      end
    end

    context "updating a space in core" do
      before do
        @entity = create(:entity, entity_id: @params["space"]["id"])
      end

      it "should update the name" do
        @hierarchy_ob.after_update(@params)
        @entity.reload
        @entity.name.should == @params["space"]["name"]
      end
    end
  end

  context "course" do
    before do
      @params =
      { "course" =>
        { "workload" => nil,
          "published" => true,
          "destroy_soon" => false,
          "description" => "",
          "name" => "Primeiro ano ",
          "subscription_type" => 1,
          "updated_at" => "2012-11-03T13:00:34-02:00",
          "path" => "primeiro-ano-",
          "user_id" => 7498,
          "environment_id" => 1044,
          "id" => 1304,
          "created_at" => "2012-10-29T22:07:53-02:00"
        }
      }
    end

    context "creating a course in core" do
      it "should create an Entity" do
        expect {
          @hierarchy_ob.after_create(@params)
        }.to change(Entity, :count).by(1)
      end


      it "should not create a wall" do
        expect {
          @hierarchy_ob.after_create(@params)
        }.to change(Wall, :count).by(0)
      end
    end

    context "updating a course in core" do
      before do
        @entity = create(:entity, entity_id: @params["course"]["id"])
      end

      it "should update the name" do
        @hierarchy_ob.after_update(@params)
        @entity.reload
        @entity.name.should == @params["course"]["name"]
      end
    end
  end

  context "environment" do
    before do
      @params = {"environment"=>
       {"initials" => "Modelo",
        "avatar_updated_at" => nil,
        "user_id" => 7498,
        "created_at" => "2012-10-29T22:07:53-02:00",
        "name" => "COLEGIO MODELO ",
        "description" => nil,
        "published" => true,
        "avatar_file_name" => nil,
        "id" => 1044,
        "destroy_soon" => false,
        "avatar_file_size" => nil,
        "path" => "colegio-modelo-",
        "updated_at" => "2012-10-29T22:07:53-02:00",
        "avatar_content_type" => nil
       }
      }
    end

    context "creating a environment in core" do
      it "should create an Entity" do
        expect {
          @hierarchy_ob.after_create(@params)
        }.to change(Entity, :count).by(1)
      end


      it "should not create a wall" do
        expect {
          @hierarchy_ob.after_create(@params)
        }.to change(Wall, :count).by(0)
      end
    end

    context "updating a environment in core" do
      before do
        @entity = create(:entity, entity_id: @params["environment"]["id"])
      end

      it "should update the name" do
        @hierarchy_ob.after_update(@params)
        @entity.reload
        @entity.name.should == @params["environment"]["name"]
      end
    end
  end
end
