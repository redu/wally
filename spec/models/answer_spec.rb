require "spec_helper"

describe Answer do
  it { should belong_to(:post).of_type(Post) }
  it { should validate_presence_of(:post) }
  it { should respond_to(:answer_url) }
end
