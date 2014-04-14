class Actor
  include Mongoid::Document
  field :name

  def do_something
    run_callbacks(:custom) do
      self.name = "custom"
    end
  end
end