require "logger"
require "rails"
require "mongoid-observers"
require "rails/application"

module ObserverIntegration
  class Application < Rails::Application
    config.root = File.expand_path("..", __dir__)
    config.eager_load = false
    config.cache_classes = false
    config.logger = ActiveSupport::Logger.new($stdout)
    config.log_level = :error
    config.secret_key_base = "a" * 64
    config.session_store :disabled
    config.mongoid.observers = [:entry_observer]
  end
end
