require 'bundler/gem_tasks'

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') &&
   Gem.loaded_specs.key?('ruby-gem-release')
  require_relative 'script/release'
  MongoidObserversRelease.workflow.install_tasks

  %w[release release:rubygem_push release:source_control_push].each do |name|
    Rake::Task[name].clear
    desc 'Disabled; releases run through GitHub Actions, see RELEASING.md'
    task(name) { abort "#{name} is disabled; releases run through GitHub Actions, see RELEASING.md" }
  end
end

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb'].exclude('spec/integration/**/*')
end

RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = FileList['spec/integration/**/*_spec.rb']
end

lint = RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') &&
       Gem.loaded_specs.key?('rubocop')
if lint
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  desc 'Lint Ruby, Markdown, YAML, and spelling'
  task lint: :rubocop
end

task default: (lint ? %i[rubocop spec integration] : %i[spec integration])

namespace :spec do
  %w[mongoid_4 mongoid_5 mongoid_6 mongoid_7 mongoid_8 mongoid_9].each do |gemfile|
    desc "Run Tests against #{gemfile}"
    task gemfile do
      sh "bundle exec appraisal #{gemfile} bundle install --quiet"
      sh "bundle exec appraisal #{gemfile} rake"
    end
  end

  desc 'Run Tests against Mongoid versions (requires compatible Ruby versions)'
  task :all do
    %w[mongoid_4 mongoid_5 mongoid_6 mongoid_7 mongoid_8 mongoid_9].each do |gemfile|
      sh "bundle exec appraisal #{gemfile} bundle install --quiet"
      sh "bundle exec appraisal #{gemfile} rake"
    end
  end
end
