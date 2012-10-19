require 'bundler/setup'
require 'goliath'
require 'grape'
require "rack/cors"

Dir["./app/**/*.rb"].each { |f| require f }

class Application < Goliath::API
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => [:get, :post,
                                                   :options, :delete]
    end

    allow do
      origins '*'
      resource '/public/*', :headers => :any, :methods => :get
    end
  end

  use(Rack::Static,:root => Goliath::Application.app_path("public"),
      :urls => ["/favicon.ico", '/css', '/js', '/img'])

  def response(env)
    ::Wally.call(env)
  end
end
