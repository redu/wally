# -*- encoding : utf-8 -*-
require "spec_helper"

describe LectureObserver do
  before do
    @lecture_ob = LectureObserver.send(:new)
    @space_id = Random.rand(0..100)
    @params = {
      "lecture" => {
        "avatar_content_type" => nil,
        "lectureable_type" => "Seminar",
        "avatar_file_name" => nil,
        "avatar_updated_at" => nil,
        "description" => "",
        "created_at" => "2012-10-29T10:37:06-02:00",
        "name" => "Espirro",
        "published" => true,
        "id" => 3596,
        "avatar_file_size" => nil,
        "subject_id" => 2309,
        "rating_average" => 0,
        "media_updated_at" => nil,
        "view_count" => 0,
        "user_id" => 5790,
        "updated_at" => "2012-10-29T10:38:41-02:00",
        "lectureable_id" => 1182,
        "removed" => false,
        "position" => 2,
        "is_clone" => false,
        "space_id" => @space_id}
    }
  end

  context "creating a lecture" do
    it "should create an Entity" do
      expect {
        @lecture_ob.after_create(@params)
      }.to change(Entity, :count).by(1)
    end

    it "should create a lecture Wall" do
      @lecture_ob.after_create(@params)
      wall = Wall.find_by(resource_id: "core:lecture_#{@params["lecture"]["id"]}")
      wall.should_not be_nil
    end

    context "when wall space already exists" do
      before do
        @wall_space = create(:wall, resource_id: "core:space_#{@space_id}")
      end

      it "should reference a Wall from space_id" do
        @lecture_ob.after_create(@params)
        wall = Wall.find_by(resource_id: "core:lecture_#{@params["lecture"]["id"]}")
        wall.reference_walls.should == [@wall_space]
      end
    end

    context "when wall spaces doesn't exists" do
      it "should create a wall space" do
        @lecture_ob.after_create(@params)
        wall = Wall.find_by(resource_id: "core:space_#{@space_id}")
        wall.should_not be_nil
      end
    end
 end

  context "updating a lecture" do
    before do
      @entity = create(:entity, entity_id: @params["lecture"]["id"])
    end

    it "should update the name" do
      @lecture_ob.after_update(@params)
      @entity.reload
      @entity.name.should == @params["lecture"]["name"]
    end
  end
end

