require "spec_helper"

RSpec.describe PubsubNotifier::Config do
  let(:config) { described_class.new }
  it { expect(config.logger).to be_a Logger }
  it { expect(config.clients).to be_a Hash }
end
