require "spec_helper"
require "./app/models/entity"

describe Entity do
  it { should have_field(:name).of_type(String) }
  it { should have_field(:entity_id).of_type(Integer) }
  it { should have_field(:api_url).of_type(String) }
  it { should have_field(:core_url).of_type(String) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:entity_id) }
  it { should validate_uniqueness_of(:entity_id) }
  it { should validate_presence_of(:api_url) }
  it { should validate_presence_of(:core_url) }

  it { have_many(:target_on_posts).of_type(Post).as_inverse_of(:target_on) }
  it { have_and_belong_to_many(:context_posts).of_type(Post).as_inverse_of(:contexts) }
end
