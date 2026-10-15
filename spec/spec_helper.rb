if ENV["COVERAGE"] == "true"
  require "simplecov"
  SimpleCov.start do
    track_files "lib/**/*.rb"
    add_filter "/spec/"
  end
end

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

require "logger"
require "rails"
require "mongoid-observers"

# mongoid connection
Mongoid.logger.level        = Logger::INFO

Mongoid.load! File.join(__dir__, "config/mongoid.yml"), :test

# Autoload every model for the test suite that sits in spec/app/models.
Dir[ File.join(MODELS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    Mongoid.purge!
  end
end
