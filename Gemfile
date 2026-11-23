source 'https://rubygems.org'

gem 'appraisal', '~> 2.5'
gem 'danger', require: false
gem 'danger-changelog', require: false
gem 'danger-pr-comment', require: false
gem 'json', '< 3' # Older ActiveSupport passes the removed quirks_mode option.
gem 'ostruct'
gem 'railties'
gem 'rake'
gem 'rspec', '~> 3.13'
gem 'simplecov', '~> 0.22', require: false

# Specify your gem's dependencies in mongoid-observers.gemspec
gemspec

group :development, :test do
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'rubocop', '~> 1.92'
    gem 'rubocop-md', '~> 3.0', require: false
    gem 'rubocop-prose', '~> 0.2', require: false
    gem 'rubocop-rake', '~> 0.7', require: false
    gem 'rubocop-spellcheck', '~> 0.2', require: false
    gem 'rubocop-yaml', '~> 0.1.0', require: false
  end
end
