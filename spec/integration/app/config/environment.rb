require_relative "application"

Mongoid.load! File.expand_path("../../../config/mongoid.yml", __dir__), :test
ObserverIntegration::Application.initialize!
