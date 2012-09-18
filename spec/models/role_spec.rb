require "spec_helper"
require "./app/models/role"
require "./app/models/author"

describe Role do
  it { should have_field(:name).of_type(String) }
  it { should have_field(:thumbnail).of_type(Hash) }

  it { should be_embedded_in(:author) }
  it { should respond_to(:thumbnails) }
end
