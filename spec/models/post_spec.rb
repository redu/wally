require 'spec_helper'

describe Post do
    it { should have_field(:action).of_type(String) }

    it { should belong_to(:target_on).of_type(Entity).as_inverse_of(:target_on_posts) }
    it { should belong_to(:origin_wall).of_type(Wall).as_inverse_of(:original_posts) }
    it { should have_many(:answers).with_dependent(:destroy) }
    it { should have_and_belong_to_many(:walls).of_type(Wall) }
    it { should have_and_belong_to_many(:context).of_type(Entity).as_inverse_of(:context_posts) }

    it { should validate_presence_of(:target_on) }
    it { should validate_presence_of(:origin_wall) }
    it { should validate_presence_of(:action) }
end
