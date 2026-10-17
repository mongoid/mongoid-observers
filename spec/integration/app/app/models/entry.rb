class Entry
  include Mongoid::Document

  field :name, type: String
  field :observed, type: Boolean, default: false
end
