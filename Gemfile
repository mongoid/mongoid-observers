source 'https://rubygems.org'

mongoid_version = ENV.fetch('MONGOID_VERSION', '9')
rails_version = ENV.fetch('RAILS_VERSION', '8.1')

gem 'mongoid', "~> #{mongoid_version}.0"
gem 'railties', "~> #{rails_version}.0"
gem 'bigdecimal', rails_version.to_f < 5 ? '< 2' : '>= 0'
gem 'json', '< 3' # Older ActiveSupport passes the removed quirks_mode option.
gem 'ostruct'
gem 'rake'
gem 'rspec', '~> 3.13'
gem 'simplecov', '~> 0.22', require: false if ENV['COVERAGE'] == 'true'

# Specify your gem's dependencies in mongoid-observers.gemspec
gemspec