require "active_support"
require "rails/observers/active_model"

require "mongoid"
require "mongoid/observers/config"
require "mongoid/observers/interceptable"
require "mongoid/observers/railtie" if defined? Rails
require "mongoid/observer"

module Mongoid
  include ActiveModel::Observing

  delegate ActiveModel::Observing::ClassMethods.public_instance_methods(false) => Config
end
