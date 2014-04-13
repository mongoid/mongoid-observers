module Mongoid
  module Composable
    extend ActiveSupport::Concern

    include ActiveModel::Observing
  end
end