require "spec_helper"

RSpec.describe PubsubNotifier::SlackClient do
  let(:client)  { described_class.new }
  let(:message) { "message" }
  let(:webhook_url) { "https://hooks.slack.com/services/_____/_____/______" }

  before do
    expect(client).to receive(:webhook_url).and_return(webhook_url)
    expect(Net::HTTP).to receive(:post_form).and_return(true)
  end

  describe "#notify_success" do
    subject { client.notify_success(message) }
    it { is_expected.to be true }
  end

  describe "#notify_failure" do
    subject { client.notify_failure(message) }
    it { is_expected.to be true }
  end
end
