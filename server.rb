require 'bundler/setup'
require 'goliath'
require 'grape'
Dir["./app/apis/*.rb"].each {|f| require f}
#require './app/apis/wally'

class Application < Goliath::API
  def response(env)
    ::Wally.call(env)
  end
end
