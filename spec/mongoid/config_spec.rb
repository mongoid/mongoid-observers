require "spec_helper"

describe "Mongoid observer configuration" do
  it "delegates observer configuration to Mongoid::Config" do
    expect(Mongoid.observers).to equal(Mongoid::Config.observers)
    expect(Mongoid.observer_instances).to equal(Mongoid::Config.observer_instances)
  end

  it "restores global observers after a disabled block" do
    observer = ActorObserver.instance
    Mongoid.observers.disable(:all) do
      expect(Mongoid.observers.disabled_for?(observer)).to eq(true)
    end
    expect(Mongoid.observers.disabled_for?(observer)).to eq(false)
    actor = Actor.create!(name: "Observed")
    expect(observer.last_after_create_record).to eq(actor)
  end

  it "restores global observers when a disabled block raises" do
    observer = ActorObserver.instance
    expect do
      Mongoid.observers.disable(:all) { raise "callback failed" }
    end.to raise_error("callback failed")
    expect(Mongoid.observers.disabled_for?(observer)).to eq(false)
  end
end
