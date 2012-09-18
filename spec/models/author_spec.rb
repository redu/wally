require "spec_helper"
require "./app/models/role"
require "./app/models/author"

describe Author do
  it { should have_field(:name).of_type(String) }
  it { should have_field(:login).of_type(String) }
  it { should have_field(:thumbnails).of_type(Hash) }
  it { should embed_one(:role) }
  it { should be_embedded_in(:entry) }
end
