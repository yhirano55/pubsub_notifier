require "active_support/core_ext/string/inflections"
require "wisper"

module PubsubNotifier
  def self.configure
    yield config
  end

  def self.config
    @_config ||= Config.new
  end

  def self.register_client(name, klass)
    config.clients[name.to_sym] = klass
  end

  def self.register_broadcaster(name, klass)
    Wisper.configuration.broadcaster(name.to_sym, klass.new)
  end

  def self.init!
    register_client :logger, PubsubNotifier::Client::LoggerClient
  end
end

require "pubsub_notifier/base"
require "pubsub_notifier/broadcasters"
require "pubsub_notifier/client"
require "pubsub_notifier/config"
require "pubsub_notifier/proxy"
require "pubsub_notifier/pubsub"
require "pubsub_notifier/railtie" if defined?(Rails)
require "pubsub_notifier/version"

PubsubNotifier.init!
