require "spec_helper"

describe Mongoid::Observers do
  it "defines its version from the standalone entry point" do
    stub_const("Mongoid::Observers", Module.new)
    load File.expand_path("../lib/mongoid/observers/version.rb", __dir__)
    expect(Mongoid::Observers::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end
end
