require "rails/railtie"

module Mongoid
  module Observers
    class Railtie < ::Rails::Railtie
      initializer "mongoid.observer" do |app|
        ActiveSupport.on_load(:mongoid) do
          if app.config.respond_to?(:mongoid)
            ::Mongoid.observers = app.config.mongoid.observers
          end
        end
      end

      # Instantitate any registered observers after Rails initialization and
      # instantiate them after being reloaded in the development environment
      config.after_initialize do |app|
        ActiveSupport.on_load(:mongoid) do
          ::Mongoid::instantiate_observers

          ActiveSupport::Reloader.to_prepare do
            ::Mongoid.instantiate_observers
          end
        end
      end
    end
  end
end
