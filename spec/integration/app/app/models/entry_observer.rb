class EntryObserver < Mongoid::Observer
  def before_create(entry)
    entry.observed = true
  end
end
