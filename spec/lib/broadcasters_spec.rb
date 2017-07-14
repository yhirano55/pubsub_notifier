require "spec_helper"

RSpec.describe PubsubNotifier::Broadcasters::Base do
  let(:broadcaster) { described_class.new }

  describe "#configure" do
    before { broadcaster.configure(x: 1, y: -> { 2 }) }

    it "sets option with value" do
      expect(broadcaster.options[:x]).to eq 1
    end

    it "sets option with proc" do
      expect(broadcaster.options[:y]).to eq 2
    end
  end

  describe "#broadcast" do
    it { expect { broadcaster.broadcast(nil, nil, nil) }.to raise_error(NotImplementedError) }
  end
end
