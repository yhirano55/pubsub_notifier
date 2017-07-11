# PubsubNotifier

Publish-Subscribe Notifier for Ruby on Rails.

This gem relies on [krisleech/wisper](https://github.com/krisleech/wisper/) provides Pub/Sub capabilities.

## Installation

```ruby
gem 'pubsub_notifier'
```

And you can run the generator, which will set up an application notifier with some useful defaults for you:

```bash
rails g pubsub_notifier:install
```

After generating your application notifier, restart the Rails server so that Rails can pick up any classes in the new `app/notifiers/` directory.

Optionally, you need to perform asynchronously. Add `sidekiq` or `resuque` to your Gemfile:

```ruby
gem 'sidekiq'
```

Then set your queue adapter of active_job:

```ruby
Rails.application.config.active_job.queue_adapter = :sidekiq
```

## Usage

### ActiveRecord

```ruby
class User < ApplicationRecord
  subscribe :UserMailer
  subscribe :UserNotifier, async: true, queue: :high
end

class UserMailer < ApplicationMailer
  acts_as_notifier

  default from: 'admin@example.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

class UserNotifier < ApplicationNotifier
  use :slack, channel: '#general', username: 'angel', icon_emoji: ':innocent:'

  def welcome(user)
    notify_success("#{user.name} has joined.")
  end
end

user = User.first
user.broadcast(:welcome) # or user.publish(:welcome)
```

### Pure Ruby Object

```ruby
class Register
  include PubsubNotifier::Proxy

  subscribe :UserRegisterNotifier

  attr_accessor :name

  validates :name, presence: true

  def execute
    if valid?
      broadcast(:success)
    else
      broadcast(:failure)
    end
  end
end

class UserRegisterNotifier < ApplicationNotifier
  use :slack, channel: '#random', username: 'noreply', icon_emoji: ':grinning:'

  def success(context)
    notify_success('succeed')
  end

  def failure(context)
    notify_failure('failure')
  end
end

register = Register.new(name: 'hello')
register.execute
```

### Configuration

```ruby
# config/initializers/pubsub_notifier.rb
PubsubNotifier.config.logger = Rails.logger

require "pubsub_notifier/slack_client"

PubsubNotifier::SlackClient.configure do |config|
  config.default_channel    = ENV['SLACK_DEFAULT_CHANNEL']
  config.default_username   = ENV['SLACK_DEFAULT_USERNAME']
  config.default_icon_emoji = ENV['SLACK_DEFAULT_ICON_EMOJI']
  config.webhook_url        = ENV['SLACK_WEBHOOK_URL']
end
```

### Generate a Notifier class

You can generate a notifier class by generate command:

```bash
rails g notifier user
      create  app/notifiers/user_notifier.rb
      invoke  test_unit
      create    test/notifiers/user_notifier_test.rb
```

### Implement Notification Client

You can easily implement Client for Notification like plugin:

```ruby
module PubsubNotifier
  class SomethingClient < ::PubsubNotifier::Client::Base
    def initialize(options = {})
      # implement this
    end

    def notify_success(message)
      # implement this
    end

    def notify_failure(message)
      # implement this
    end

    def something_special(*args)
      # implement if you need
    end
  end
end

PubsubNotifier.clients :something, PubsubNotifier::SomethingClient
```

Then you can use on a notifier class:

```ruby
class SomeNotifier < ApplicationNotifier
  use :something

  def welcome(recipient)
    notify_success(recipient.name)
  end
end
```

If you want to know more information to implement notification client, please check  `lib/pubsub_notifier/slack_client.rb`.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
