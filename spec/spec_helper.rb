# -*- encoding : utf-8 -*-
$:.unshift File.expand_path("#{File.dirname(__FILE__)}/..")

require 'bundler/setup'

# 3rd party dependencies
require 'rack/test'
require 'factory_girl'
require 'webmock/rspec'
require 'mongoid-rspec'
require 'untied-consumer'
require 'debugger'

require 'boot'
require 'support/base'

Dir['./observers/*.rb'].each { |f| require f }

WallyConfig.configure do |c|
  c.env = :test
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

 # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  Permit.configure do |config|
    config.deliver_messages = false
    config.service_name = 'wally'
  end

  config.include Rack::Test::Methods
  config.include Mongoid::Matchers
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions
  config.include WallySupport::Helpers

  config.before :each do
    Mongoid.purge!
  end

  config.after :each do
    Mongoid.purge!
  end

  config.before(:each) do
    WebMock.allow_net_connect!
  end
end

