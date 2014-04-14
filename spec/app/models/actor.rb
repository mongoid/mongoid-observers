class Actor
  include Mongoid::Document
  field :name
  field :after_custom_count, type: Integer, default: 0

  define_model_callbacks :custom
  observable :custom

  def do_something
    run_callbacks(:custom) do
      self.name = "custom"
    end
  end
end