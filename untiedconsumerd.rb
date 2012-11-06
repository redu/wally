$:.unshift File.dirname(__FILE__)

require "bundler/setup"
require "untied-consumer"
require "untied-consumer/worker"
require "boot"

require "observers/hierarchy_observer"
require "observers/lecture_observer"
require "observers/user_observer"

Untied::Consumer.configure do |c|
  c.observers = [HierarchyObserver, LectureObserver, UserObserver]
end

log_dir = File.expand_path File.join(File.dirname(__FILE__), 'log')
pids_dir = File.expand_path File.join(File.dirname(__FILE__), 'tmp', 'pids')

worker = Untied::Consumer::Worker.new
worker.daemonize(:pids_dir => pids_dir, :log_dir => log_dir)
