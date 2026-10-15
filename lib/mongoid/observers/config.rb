module Mongoid
  module Config
    include ActiveModel::Observing

    # Config is a module, not an ORM base class with inheriting models.
    def self.descendants
      []
    end
  end
end