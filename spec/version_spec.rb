require "spec_helper"

describe Mongoid::Observers do
  it "defines a semantic version" do
    expect(Mongoid::Observers::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end
end
