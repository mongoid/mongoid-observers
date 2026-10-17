require_relative "rails_helper"

describe "Rails observer integration" do
  it "applies application configuration and invokes observers on persisted records" do
    expect(Mongoid.observers).to eq([:entry_observer])
    entry = Entry.create!(name: "initialized")

    expect(entry.reload.observed).to eq(true)
  end

  it "reloads models and registers their observers again" do
    original_model = Entry
    original_observer = EntryObserver

    if Rails.application.respond_to?(:reloader)
      Rails.application.reloader.reload!
    else
      ActionDispatch::Reloader.cleanup!
      ActionDispatch::Reloader.prepare!
    end

    expect(Entry).not_to equal(original_model)
    expect(EntryObserver).not_to equal(original_observer)
    entry = Entry.create!(name: "reloaded")
    expect(entry.reload.observed).to eq(true)
  end
end
