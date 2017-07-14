require "spec_helper"
require "pubsub_notifier/acts_as_notifier"

RSpec.describe PubsubNotifier::ActsAsNotifier do
  let(:dummy) do
    Class.new do
      include PubsubNotifier::ActsAsNotifier
      acts_as_notifier

      class << self
        def action_methods
          %w(welcome)
        end
      end
    end
  end

  before do
    allow_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver)
  end

  describe '.method_missing' do
    subject { dummy.send(method_name) }

    context 'when method_name is included one of actions' do
      let(:method_name) { :welcome }
      it { is_expected.to be_a ActionMailer::MessageDelivery }
    end

    context 'when method_name is not included one of actions' do
      let(:method_name) { :hello }

      it 'returns raise error' do
        expect { subject }.to raise_error(NoMethodError)
      end
    end
  end
end
