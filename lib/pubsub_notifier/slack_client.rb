require 'net/http'
require 'json'
require 'uri'

module PubsubNotifier
  class SlackClient < ::PubsubNotifier::Client::Base
    attr_reader :channel, :username, :icon_emoji

    def initialize(options = {})
      @channel    = options.delete(:channel)    || default_channel
      @username   = options.delete(:username)   || default_username
      @icon_emoji = options.delete(:icon_emoji) || default_icon_emoji
    end

    def notify_success(message)
      post_slack(
        attachments: [{
          text:      message,
          color:     'good',
          mrkdwn_in: ['text'],
        }],
      )
    end

    def notify_failure(message)
      post_slack(
        attachments: [{
          text:      message,
          color:     'danger',
          mrkdwn_in: ['text'],
        }],
      )
    end

    private

      def post_slack(payload)
        Net::HTTP.post_form(
          end_point_uri,
          payload: default_payload.merge(payload).to_json,
        )
      end

      def end_point_uri
        @end_point_uri ||= URI.parse(webhook_url)
      end

      def default_payload
        {
          channel:    channel,
          link_names: 1,
          username:   username,
          icon_emoji: icon_emoji,
        }
      end

      def default_channel
        config.default_channel
      end

      def default_username
        config.default_username
      end

      def default_icon_emoji
        config.default_icon_emoji
      end

      def webhook_url
        config.webhook_url
      end

    class Config
      attr_accessor :default_channel, :default_username, :default_icon_emoji, :webhook_url

      def initialize
        @default_channel    = ENV['SLACK_DEFAULT_CHANNEL']
        @default_username   = ENV['SLACK_DEFAULT_USERNAME']
        @default_icon_emoji = ENV['SLACK_DEFAULT_ICON_EMOJI']
        @webhook_url        = ENV['SLACK_WEBHOOK_URL']
      end
    end
  end
end

PubsubNotifier.register_client :slack, PubsubNotifier::SlackClient
