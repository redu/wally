require "spec_helper"

describe Author do
  it { should have_field(:user_id).of_type(Integer) }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:login).of_type(String) }
  it { should have_field(:thumbnails).of_type(Array) }
  it { should have_field(:token).of_type(String) }
  it { should embed_one(:role) }
  it { should have_many(:entries).of_type(Entry) }

  it { should validate_presence_of :token }
  it { should validate_presence_of :user_id }
  it { should validate_uniqueness_of :user_id }
  it { should validate_uniqueness_of :token }

  context "methods" do
    before do
      @author = create(:author)
    end

    it "should return correct subject_permit" do
      @author.subject_permit.should == "core:users_#{@author.user_id}"
    end

    it "should return correct api_url" do
      @author.api_url.should == "http://www.redu.com.br/api/users/#{@author.user_id}"
    end

    it "should return correct perfil_url" do
      @author.perfil_url.should == "http://www.redu.com.br/pessoas/#{@author.login}"
    end
  end
end
