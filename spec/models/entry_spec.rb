require 'spec_helper'

describe Entry do
  it { should have_field(:created_at).of_type(DateTime) }
  it { should have_field(:content).of_type(Hash) }
  it { should have_field(:rule).of_type(Hash) }

  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:author) }
  it { should belong_to(:author).of_type(Author) }
end
