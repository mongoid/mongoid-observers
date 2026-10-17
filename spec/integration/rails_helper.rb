ENV["RAILS_ENV"] = "test"

if ENV["COVERAGE"] == "true"
  require "simplecov"
  SimpleCov.command_name "Rails integration"
  SimpleCov.start do
    track_files "lib/**/*.rb"
    add_filter "/spec/"
  end
end

require_relative "app/config/environment"

RSpec.configure do |config|
  config.before(:each) { Mongoid.purge! }
end
