require "spec_helper"
require "open3"
require "rbconfig"

describe "Rails observer lifecycle" do
  it "configures, instantiates and reloads observers in a real application" do
    script = <<-'RUBY'
      require "rspec"
      require "spec_helper"
      if ENV["COVERAGE"] == "true"
        SimpleCov.command_name "Rails observer lifecycle"
      end
      require "rails/application"

      class ObserverCoverageApplication < Rails::Application
        config.root = File.expand_path("spec", Dir.pwd)
        config.eager_load = false
        config.logger = ActiveSupport::Logger.new($stdout)
        config.log_level = :error
        config.secret_key_base = "a" * 64
        config.session_store :disabled
        config.mongoid.observers = [:actor_observer]
      end

      instantiations = 0
      instantiate = Mongoid.method(:instantiate_observers)
      Mongoid.define_singleton_method(:instantiate_observers) do
        instantiations += 1
        instantiate.call
      end
      ObserverCoverageApplication.initialize!
      raise "observer configuration was not applied" unless Mongoid.observers == [:actor_observer]
      raise "observers were not instantiated" unless instantiations > 0
      initial_instantiations = instantiations

      if defined?(ActiveSupport::Reloader)
        ActiveSupport::Reloader.prepare!
      else
        ActionDispatch::Reloader.prepare!
      end
      raise "observers were not reinstantiated on reload" unless instantiations > initial_instantiations

      observer = ActorObserver.instance
      actor = Actor.create!(name: "Rails lifecycle")
      raise "observer did not run after reload" unless observer.last_after_create_record == actor
      puts "observer lifecycle complete"
    RUBY
    output, status = Open3.capture2e({"RAILS_ENV" => "test"}, RbConfig.ruby, "-Ispec", "-e", script)
    expect(status.success?).to eq(true), output
    expect(output).to include("observer lifecycle complete")
  end
end
