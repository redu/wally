$: << File.dirname(__FILE__)

require "bundler/setup"
require "untied-consumer"
require "mongoid"
require "grape"
require "./boot"
require "debugger"

Dir["./observers/*.rb"].each { |f| require f }

Untied::Consumer.configure do |c|
  c.observers = [AuthorObserver]
end

Mongoid.load!("./config/mongoid.yml", :development)

load "untied-consumer/tasks/untied.tasks"
