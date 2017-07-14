require "spec_helper"

RSpec.describe PubsubNotifier::Broadcasters::ActiveJobBroadcaster do
  let(:broadcaster) { described_class.new }
  let(:configured_job) { double(:configured_job) }

  let(:subscriber) do
    Struct.new(:name) do
      attr_reader :name
    end
  end

  subject { broadcaster.broadcast(subscriber.new(name: :sub), nil, nil, nil) }

  context "when global_id is not blank" do
    before do
      allow(broadcaster).to receive(:configured_job).and_return(configured_job)
      allow(configured_job).to receive(:perform_later).and_return(:perform_later)
    end

    it { is_expected.to eq :perform_later }
  end

  context "when global_id is blank" do
    before do
      allow(broadcaster).to receive(:configured_job).and_return(configured_job)
      allow(configured_job).to receive(:perform_later).and_raise(::ActiveJob::SerializationError)
      allow(configured_job).to receive(:perform_now).and_return(:perform_now)
    end

    it { is_expected.to eq :perform_now }
  end
end
