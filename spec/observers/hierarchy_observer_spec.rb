require "spec_helper"

describe HierarchyObserver do
  before do
    @hierarchy_ob = HierarchyObserver.send(:new)
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

    it "should create a Wall" do
      expect {
        @hierarchy_ob.after_create(@params)
      }.to change(Wall, :count).by(1)
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
