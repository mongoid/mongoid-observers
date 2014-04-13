require "rails/observers/active_model"
require "mongoid"
require "mongoid/observers/config"
require "mongoid/observers/composable"
require "mongoid/observers/railtie" if defined? Rails
require "mongoid/observer"

module Mongoid
  include ActiveModel::Observing

  delegate(*ActiveModel::Observing::ClassMethods.public_instance_methods(false) <<
    { to: Config })
end