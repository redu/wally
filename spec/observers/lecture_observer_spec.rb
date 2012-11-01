require "spec_helper"

describe LectureObserver do
  before do
    @lecture_ob = LectureObserver.send(:new)
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
        "is_clone" => false }
    }
  end

  context "creating a lecture" do
    it "should create an Entity" do
      expect {
        @lecture_ob.after_create(@params)
      }.to change(Entity, :count).by(1)
    end

    it "should create a Wall" do
      expect {
        @lecture_ob.after_create(@params)
      }.to change(Wall, :count).by(1)
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
