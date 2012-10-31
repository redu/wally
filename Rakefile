$:.unshift File.dirname(__FILE__)

require "bundler/setup"
require "untied-consumer"
require "boot"
Dir["./observers/*.rb"].each { |f| require f }

Untied::Consumer.configure do |c|
  c.observers = [AuthorObserver]
end

Mongoid.load!("./config/mongoid.yml", WallyConfig.config.env)

load "untied-consumer/tasks/untied.tasks"
