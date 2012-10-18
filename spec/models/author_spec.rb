require "spec_helper"

describe Author do
  it { should have_field(:user_id).of_type(Integer) }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:login).of_type(String) }
  it { should have_field(:perfil_url).of_type(String) }
  it { should have_field(:api_url).of_type(String) }
  it { should have_field(:thumbnails).of_type(Array) }
  it { should have_field(:token).of_type(String) }
  it { should embed_one(:role) }
  it { should have_many(:entries).of_type(Entry) }

  it { should validate_presence_of :token }
  it { should validate_presence_of :user_id }
  it { should validate_uniqueness_of :user_id }
  it { should validate_uniqueness_of :token }
end
