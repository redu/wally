require 'spec_helper'
require './app/models/wall'
require 'debugger'

describe Wall do
  it { should have_field(:resource_id).of_type(String) }
  it { should validate_presence_of(:resource_id) }
  it { should validate_uniqueness_of(:resource_id) }
  it { should have_and_belong_to_many(:posts) }

  subject { create(:wall) }

  context "callbacks" do
    context "after destroy" do
      it "should destroy posts that have wall_id = subject.id" do
        5.times do
          subject.posts << create_post_on_wall(1)
        end
        5.times do
          subject.posts << create_post_on_wall(subject.id)
        end
        expect {
          subject.destroy
        }.to change(Post, :count).by(-5)
      end
    end
  end

  def create_post_on_wall(origin_wall)
    author = build(:author)
    post = build(:post, origin_wall: origin_wall)
    post.author = author
    post
  end
end
