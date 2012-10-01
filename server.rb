require 'bundler/setup'
require 'goliath'
require 'grape'
Dir["./app/**/*.rb"].each { |f| require f }

class Application < Goliath::API
  def response(env)
    ::Wally.call(env)
  end
end
