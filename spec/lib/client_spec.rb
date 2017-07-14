require "spec_helper"

RSpec.describe PubsubNotifier::Client::Base do
  let(:client) { described_class.new }

  describe '.configure' do
    it { expect { described_class.configure(&:object_id) }.to raise_error(NameError) }
  end

  describe '.config' do
    it { expect { described_class.config }.to raise_error(NameError) }
  end

  describe '#notify_success' do
    it { expect { client.notify_success("message") }.to raise_error(NotImplementedError) }
  end

  describe '#notify_failure' do
    it { expect { client.notify_failure("message") }.to raise_error(NotImplementedError) }
  end
end

RSpec.describe PubsubNotifier::Client::LoggerClient do
  let(:client) { described_class.new }

  describe '#notify_success' do
    it { expect { client.notify_success("message") }.not_to raise_error }
  end

  describe '#notify_failure' do
    it { expect { client.notify_failure("message") }.not_to raise_error }
  end
end
