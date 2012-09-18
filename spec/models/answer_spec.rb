require "spec_helper"
require "./app/models/entry"
require "./app/models/answer"

describe Answer do
  it { should have_field(:post_id).of_type(Integer) }
  it { should respond_to(:answer_url) }
end
