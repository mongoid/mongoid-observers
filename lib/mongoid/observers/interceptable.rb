module Mongoid
  module Interceptable
    include ActiveModel::Observing

    class << self

      # Get all callbacks that can be observed.
      #
      # @example Get the observables.
      #   Interceptable.observables
      #
      # @return [ Array<Symbol> ] The names of the observables.
      def observables
        CALLBACKS + registered_observables
      end

      # Get all registered callbacks that can be observed, not included in
      # Mongoid's defaults.
      #
      # @example Get the observables.
      #   Interceptable.registered_observables
      #
      # @return [ Array<Symbol> ] The names of the registered observables.
      def registered_observables
        @registered_observables ||= []
      end
    end

    module ClassMethods

      # Set a custom callback as able to be observed.
      #
      # @example Set a custom callback as observable.
      #   class Band
      #     include Mongoid::Document
      #
      #     define_model_callbacks :notification
      #     observable :notification
      #   end
      #
      # @param [ Array<Symbol> ] args The names of the observable callbacks.
      #
      # @since 3.0.1
      def observable(*args)
        observables = args.flat_map do |name|
          [ :"before_#{name}", :"after_#{name}", :"around_#{name}" ]
        end
        Interceptable.registered_observables.concat(observables).uniq
      end
    end
  end
end