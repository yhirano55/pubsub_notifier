require "spec_helper"

RSpec.describe PubsubNotifier::Proxy do
  let(:model) do
    Class.new do
      include PubsubNotifier::Proxy
    end
  end

  let(:instance) { model.new }

  describe ".subscribe" do
    subject { model.subscribe(subscriber_name) }

    context "when subscriber_name exists" do
      let(:subscriber_name) { :Hash }
      it { expect { subject }.not_to raise_error }
    end

    context "when subscriber_name does not exists" do
      let(:subscriber_name) { :Undefined }
      it { expect { subject }.to raise_error(NameError) }
    end
  end

  describe ".pubsub" do
    subject { model.pubsub }
    it { is_expected.to be_a PubsubNotifier::Pubsub }
  end

  describe "#broadcast" do
    subject { instance.broadcast(event) }

    context "when model has subscribed" do
      before do
        model.subscribe :Hash
        model.subscribe :String
      end

      context "with calling exist event" do
        let(:event) { :eql? }
        it { expect { subject }.not_to raise_error }
      end

      context "with calling not exist event" do
        let(:event) { :undefined_method_event }
        it { expect { subject }.not_to raise_error }
      end
    end

    context "when model has not subscribed" do
      let(:event) { :object_id }
      it { expect { subject }.not_to raise_error }
    end
  end

  describe "#publish" do
    it { expect(instance).to be_respond_to(:publish) }
  end
end
