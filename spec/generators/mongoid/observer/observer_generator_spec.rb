require "spec_helper"

# Generators are not automatically loaded by Rails
require "generators/mongoid/observer/observer_generator"

describe Mongoid::Generators::ObserverGenerator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path("../../../../../spec/tmp", __FILE__)

  before do
    prepare_destination
  end

  it "observer without namespace" do
    run_generator %w(product)
    expect(file("app/models/product_observer.rb")).to exist
    expect(file("app/models/product_observer.rb")).to contain(/class ProductObserver < Mongoid::Observer/)
  end

  it "observer with namespace" do
    run_generator %w(admin/account)
    expect(file("app/models/admin/account_observer.rb")).to exist
    expect(file("app/models/admin/account_observer.rb")).to contain(/class Admin::AccountObserver < Mongoid::Observer/)
  end
end