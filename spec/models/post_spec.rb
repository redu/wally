require 'spec_helper'
require "./app/models/entry"
require './app/models/post'

describe Post do
    it { should have_field(:origin_wall).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:owner_id).of_type(Integer) }
    it { should have_field(:action).of_type(String) }

    it { should belong_to(:target_on).of_type(Entity).as_inverse_of(:target_on_posts) }
    it { should have_many(:answers).with_dependent(:destroy) }
    it { should have_and_belong_to_many(:walls).of_type(Wall) }
    it { should have_and_belong_to_many(:contexts).of_type(Entity).as_inverse_of(:context_posts) }
end
