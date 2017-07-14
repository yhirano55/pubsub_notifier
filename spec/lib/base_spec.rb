require "spec_helper"

RSpec.describe PubsubNotifier::Base do
  let(:client) do
    Class.new do
      attr_reader :name, :options

      def initialize(options = {})
        @name    = :client
        @options = options
      end
    end
  end

  let(:logger) do
    Class.new do
      attr_reader :name, :options

      def initialize(options = {})
        @name    = :logger
        @options = options
      end
    end
  end

  let(:name)    { :dummy }
  let(:options) { { superman: 12345 } }

  before do
    configuration = double(:configuration, clients: { name => client, :logger => logger })
    allow(PubsubNotifier).to receive(:config).and_return(configuration)
  end

  it 'sets client' do
    described_class.use(name, options)
    expect(described_class.client).to be_a client
    expect(described_class.client.name).to eq :client
    expect(described_class.client.options).to eq options

    described_class.use(:logger, options)
    expect(described_class.client).to be_a logger
    expect(described_class.client.name).to eq :logger
    expect(described_class.client.options).to eq options

    described_class.use(:undefined, options)
    expect(described_class.client).to be_a logger
    expect(described_class.client.name).to eq :logger
    expect(described_class.client.options).to eq options
  end

  it 'returns client' do
    expect(described_class.client).not_to be_nil
    expect(described_class.client).not_to be logger
  end
end
