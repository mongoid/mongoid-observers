require "rails/railtie"

module Mongoid
  module Observers
    class Railtie < ::Rails::Railtie
      initializer "mongoid.observer" do |app|
        ActiveSupport.on_load(:mongoid) do
          if observers = app.config.respond_to?(:mongoid) && app.config.mongoid.delete(:observers)
            send :observers=, observers
          end
        end
      end

      # Instantitate any registered observers after Rails initialization and
      # instantiate them after being reloaded in the development environment
      config.after_initialize do |app|
        ActiveSupport.on_load(:mongoid) do
          ::Mongoid::instantiate_observers

          ActionDispatch::Reloader.to_prepare do
            ::Mongoid.instantiate_observers
          end
        end
      end
    end
  end
end
