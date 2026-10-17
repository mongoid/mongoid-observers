require "bundler/gem_tasks"

require "rspec/core"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList["spec/**/*_spec.rb"].exclude("spec/integration/**/*")
end

RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = FileList["spec/integration/**/*_spec.rb"]
end

task :default => [:spec, :integration]

namespace :spec do
  %w(mongoid_4 mongoid_5 mongoid_6 mongoid_7 mongoid_8 mongoid_9).each do |gemfile|
    desc "Run Tests against #{gemfile}"
    task gemfile do
      sh "bundle exec appraisal #{gemfile} bundle install --quiet"
      sh "bundle exec appraisal #{gemfile} rake"
    end
  end

  desc "Run Tests against Mongoid versions (requires compatible Ruby versions)"
  task :all do
    %w(mongoid_4 mongoid_5 mongoid_6 mongoid_7 mongoid_8 mongoid_9).each do |gemfile|
      sh "bundle exec appraisal #{gemfile} bundle install --quiet"
      sh "bundle exec appraisal #{gemfile} rake"
    end
  end
end
