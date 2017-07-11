PubsubNotifier.config.logger = Rails.logger

require "pubsub_notifier/slack_client"

PubsubNotifier::SlackClient.configure do |config|
  config.default_channel    = ENV['SLACK_DEFAULT_CHANNEL']
  config.default_username   = ENV['SLACK_DEFAULT_USERNAME']
  config.default_icon_emoji = ENV['SLACK_DEFAULT_ICON_EMOJI']
  config.webhook_url        = ENV['SLACK_WEBHOOK_URL']
end
