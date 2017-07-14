require "spec_helper"

RSpec.describe PubsubNotifier::Pubsub do
  describe '#call' do
    let(:pubsub) { described_class.new }

    subject { pubsub.call(:event) }

    it 'calls broadcast' do
      expect(pubsub).to receive(:broadcast).and_return(true)
      is_expected.to be true
    end
  end
end
