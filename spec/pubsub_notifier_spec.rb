require "spec_helper"

RSpec.describe PubsubNotifier do
  describe ".configure" do
    subject { described_class.configure(&:logger) }
    it { is_expected.to be_a Logger }
  end

  describe ".config" do
    subject { described_class.config }
    it { is_expected.to be_an_instance_of described_class::Config }
  end

  describe ".register_client" do
    let(:name)  { :client }
    let(:klass) { Object }

    before do
      described_class.register_client(name, klass)
    end

    after do
      described_class.config.clients.delete(name)
    end

    it "registers notification client" do
      expect(described_class.config.clients.has_key?(name)).to be true
    end
  end

  describe ".register_broadcaster" do
    let(:name)  { :client }
    let(:klass) { Object }

    subject { described_class.register_broadcaster(name, klass) }

    before do
      config = double("configuration", broadcaster: true)
      allow(Wisper).to receive(:configuration).and_return(config)
    end

    it "register broadcaster" do
      is_expected.to be true
    end
  end

  describe ".init!" do
    it { expect { described_class.init! }.not_to raise_error }
  end
end
