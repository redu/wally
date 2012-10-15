require 'spec_helper'

describe Entry do
  it { should have_field(:created_at).of_type(DateTime) }
  it { should have_field(:content).of_type(Hash) }

  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:author) }
  it { should belong_to(:author).of_type(Author) }


  describe "custom validations" do
    context "content" do
      it "should validate text value of content" do
        invalid_entry = build(:entry, content: { text: "" })
        invalid_entry.should_not be_valid
      end
    end
  end
end
