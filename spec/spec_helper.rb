require "simplecov"
require "coveralls"
require "codeclimate-test-reporter"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
end

require "pry"
require "database_cleaner"
require "logger"

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.around(:each) do |example|
    if example.metadata[:log]
      Mongoid.logger.level = Logger::DEBUG
      Moped.logger.level = Logger::DEBUG
    end

    DatabaseCleaner.start

    example.run

    if example.metadata[:log]
      Mongoid.logger.level = Logger::INFO
      Moped.logger.level = Logger::INFO
    end

    DatabaseCleaner.clean
  end
end