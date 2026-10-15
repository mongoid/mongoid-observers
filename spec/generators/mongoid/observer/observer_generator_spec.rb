require "spec_helper"
require "tmpdir"

# Generators are not automatically loaded by Rails
require "generators/mongoid/observer/observer_generator"

describe Mongoid::Generators::ObserverGenerator do
  around do |example|
    Dir.mktmpdir("mongoid-observer-generator") do |destination|
      @destination = destination
      example.run
    end
  end

  it "observer without namespace" do
    described_class.start(["product"], destination_root: @destination)
    output = File.read(File.join(@destination, "app/models/product_observer.rb"))
    expect(output).to include("class ProductObserver < Mongoid::Observer")
  end

  it "observer with namespace" do
    described_class.start(["admin/account"], destination_root: @destination)
    output = File.read(File.join(@destination, "app/models/admin/account_observer.rb"))
    expect(output).to include("class Admin::AccountObserver < Mongoid::Observer")
  end
end