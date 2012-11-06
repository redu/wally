$:.unshift File.dirname(__FILE__)

require "bundler/setup"
require "untied-consumer"
require "untied-consumer/worker"
require "boot"

Dir["./observers/*.rb"].each { |f| require f }

Untied::Consumer.configure do |c|
  c.observers = [HierarchyObserver]
end

log_dir = File.expand_path File.join(File.dirname(__FILE__), 'log')
pids_dir = File.expand_path File.join(File.dirname(__FILE__), 'tmp', 'pids')

worker = Untied::Consumer::Worker.new
worker.daemonize(:pids_dir => pids_dir, :log_dir => log_dir)
