class Record
  include Mongoid::Document
  field :name, type: String

  field :before_create_called, type: Boolean, default: false
  field :before_save_called, type: Boolean, default: false
  field :before_update_called, type: Boolean, default: false
  field :before_validation_called, type: Boolean, default: false
  field :before_destroy_called, type: Boolean, default: false

  before_create :before_create_stub
  before_save :before_save_stub
  before_update :before_update_stub
  before_validation :before_validation_stub
  before_destroy :before_destroy_stub

  after_destroy :access_band

  def before_create_stub
    self.before_create_called = true
  end

  def before_save_stub
    self.before_save_called = true
  end

  def before_update_stub
    self.before_update_called = true
  end

  def before_validation_stub
    self.before_validation_called = true
  end

  def before_destroy_stub
    self.before_destroy_called = true
  end

  def access_band
    band.name
  end
end