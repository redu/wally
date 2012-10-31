require 'configurable'
require 'logger'

module WallyConfig
  def self.configure(&block)
    yield(config)
  end

  def self.config
    @@config ||= Config.new
  end

  class Config
    include Configurable

    config :env, (ENV['RACK_ENV'] || "development").to_sym
    config :logger, Logger.new(STDOUT)
    config :root, File.expand_path("#{File.dirname(__FILE__)}/..")
  end
end
