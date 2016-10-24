require "simplecov"
require "coveralls"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
])

SimpleCov.start do
  add_filter "/spec/"
end

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

require "pry"
require "rails/all"
require "mongoid-observers"
require "ammeter/init"

# mongoid connection
Mongoid.logger.level        = Logger::INFO

if Mongoid::VERSION.start_with?('4.')
  Mongoid.load! File.dirname(__FILE__) + "/config/mongoid_4.yml", :test
elsif Mongoid::VERSION.start_with?('5.')
  Mongoid.load! File.dirname(__FILE__) + "/config/mongoid_5.yml", :test
elsif Mongoid::VERSION.start_with?('6.')
  Mongoid.load! File.dirname(__FILE__) + "/config/mongoid_6.yml", :test
end

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
