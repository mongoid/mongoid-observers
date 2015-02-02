require "spec_helper"

describe Mongoid::Observer do

  let(:recorder) do
    CallbackRecorder.instance
  end

  after do
    recorder.reset
  end

  it "is an instance of an active model observer" do
    expect(ActorObserver.instance).to be_a_kind_of(ActiveModel::Observer)
  end

  context "when the oberserver observes a different class" do

    before(:all) do
      class BandObserver < Mongoid::Observer
        observe :record
      end
    end

    after(:all) do
      Object.send(:remove_const, :BandObserver)
    end

    it "returns the proper observed classes" do
      expect(BandObserver.observed_classes).to eq([ Record ])
    end
  end

  context "when the observer is for an embedded document" do

    before do
      PhoneObserver.instance
    end

    let(:person) do
      Person.create
    end

    let!(:phone) do
      person.phone_numbers.create(number: "0152-1111-1111")
    end

    context "when updating the embedded document" do

      before do
        phone.update_attribute(:number, "0152-2222-2222")
      end

      it "contains the updated value in the observer" do
        expect(phone.number_in_observer).to eq("0152-2222-2222")
      end
    end
  end

  context "when the observer has descendants" do

    let!(:observer) do
      ActorObserver.instance
    end

    let!(:actress) do
      Actress.create!(name: "Tina Fey")
    end

    it "observes descendent class" do
      expect(observer.last_after_create_record.try(:name)).to eq(actress.name)
    end
  end

  context "when the observer is disabled" do

    let!(:observer) do
      ActorObserver.instance
    end

    let(:actor) do
      Actor.create!(name: "Johnny Depp")
    end

    it "does not fire the observer" do
      Actor.observers.disable(:all) do
        actor and expect(observer.last_after_create_record).not_to eq(actor)
      end
    end
  end

  context "when all observers are disabled" do

    let!(:observer) do
      ActorObserver.instance
    end

    let(:actor) do
      Actor.create!(name: "Johnny Depp")
    end

    it "does not fire the observer" do
      Mongoid.observers.disable(:all) do
        actor and expect(observer.last_after_create_record).not_to eq(actor)
      end
    end
  end

  context "when the document is new" do

    let!(:actor) do
      Actor.new
    end

    it "observes after initialize" do
      expect(recorder.last_callback).to eq(:after_initialize)
    end

    it "calls after initialize once" do
      expect(recorder.call_count[:after_initialize]).to eq(1)
    end

    it "contains the model of the callback" do
      expect(recorder.last_record[:after_initialize]).to eq(actor)
    end
  end

  context "when the document is being created" do

    let!(:actor) do
      Actor.create!
    end

    [ :before_create,
      :after_create,
      :around_create,
      :before_save,
      :after_save,
      :around_save ].each do |callback|

      it "observes #{callback}" do
        expect(recorder.call_count[callback]).to eq(1)
      end

      it "contains the model of the callback" do
        expect(recorder.last_record[callback]).to eq(actor)
      end
    end
  end

  context "when the document is being updated" do

    let!(:actor) do
      Actor.create!
    end

    [ :before_update,
      :after_update,
      :around_update,
      :before_save,
      :after_save,
      :around_save ].each do |callback|

      before do
        recorder.reset
        actor.update_attributes!(name: "Johnny Depp")
      end

      it "observes #{callback}" do
        expect(recorder.call_count[callback]).to eq(1)
      end

      it "contains the model of the callback" do
        expect(recorder.last_record[callback]).to eq(actor)
      end
    end
  end

  context "when the document is being upserted" do

    let!(:actor) do
      Actor.create!
    end

    [ :before_upsert,
      :after_upsert,
      :around_upsert ].each do |callback|

      before do
        recorder.reset
        actor.upsert
      end

      it "observes #{callback}" do
        expect(recorder.call_count[callback]).to eq(1)
      end

      it "contains the model of the callback" do
        expect(recorder.last_record[callback]).to eq(actor)
      end
    end
  end

  context "when custom callbacks are being fired" do

    let!(:actor) do
      Actor.create!
    end

    [ :before_custom,
      :after_custom,
      :around_custom ].each do |callback|

      before do
        recorder.reset
        actor.run_callbacks(:custom) do
        end
      end

      it "observes #{callback}" do
        expect(recorder.call_count[callback]).to eq(1)
      end

      it "contains the model of the callback" do
        expect(recorder.last_record[callback]).to eq(actor)
      end
    end
  end

  context "when the document is being destroyed" do

    let!(:actor) do
      Actor.create!
    end

    [ :before_destroy, :after_destroy, :around_destroy ].each do |callback|

      before do
        recorder.reset
        actor.destroy
      end

      it "observes #{callback}" do
        expect(recorder.call_count[callback]).to eq(1)
      end

      it "contains the model of the callback" do
        expect(recorder.last_record[callback]).to eq(actor)
      end
    end
  end

  context "when the document is being validated" do

    let!(:actor) do
      Actor.new
    end

    [:before_validation, :after_validation].each do |callback|

      before do
        recorder.reset
        actor.valid?
      end

      it "observes #{callback}" do
        expect(recorder.call_count[callback]).to eq(1)
      end

      it "contains the model of the callback" do
        expect(recorder.last_record[callback]).to eq(actor)
      end
    end
  end

  context "when using a custom callback" do

    let(:actor) do
      Actor.new
    end

    before do
      actor.do_something
    end

    it "notifies the observers once" do
      expect(actor.after_custom_count).to eq(1)
    end
  end
end