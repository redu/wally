require 'spec_helper'
require "./app/models/entry"
require './app/models/post'

describe Post do
    it { should have_field(:wall_id).of_type(Integer) }
    it { should have_field(:target_on).of_type(Hash) }
    it { should have_field(:context).of_type(Hash) }
    it { should have_field(:action).of_type(String) }

    it { should have_many(:answers).with_dependent(:destroy) }
end
