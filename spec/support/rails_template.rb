rails_major_version = Rails::VERSION::STRING[0].to_i

# Configure default_url_options in test environment
inject_into_file "config/environments/test.rb",
                 "  config.action_mailer.default_url_options = { :host => 'example.com' }\n",
                 after: "config.cache_classes = true\n"

# Add our local pubsub_notifier to the load path
inject_into_file "config/environment.rb",
                 "\n$LOAD_PATH.unshift('#{File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib"))}')\nrequire \"pubsub_notifier\"\n",
                 after: (rails_major_version >= 5) ? "require_relative 'application'" : "require File.expand_path('../application', __FILE__)"

run "rm Gemfile"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

# Install
generate :'pubsub_notifier:install'

# Generate Notifiers
generate :notifier, "user"
generate :notifier, "post"

# Generate Mailer
generate :mailer, "user_mailer success"
inject_into_file "app/mailers/user_mailer.rb", "  acts_as_notifier\n",
                 after: (rails_major_version >= 5) ? "ApplicationMailer\n" : "ActionMailer::Base\n"
inject_into_file "app/mailers/user_mailer.rb", "(recipient)", after: "def success"

generate :mailer, "post_mailer failure"
inject_into_file "app/mailers/post_mailer.rb", "  acts_as_notifier\n",
                 after: (rails_major_version >= 5) ? "ApplicationMailer\n" : "ActionMailer::Base\n"
inject_into_file "app/mailers/post_mailer.rb", "(recipient)", after: "def failure"

# Generate ActiveRecord Models
generate :model, "User name:string"
inject_into_file "app/models/user.rb", "  subscribe :UserNotifier\n  subscribe :PostNotifier\n  subscribe :UserMailer\n  subscribe :PostMailer\n", before: "end"

generate :model, "Post name:string"
inject_into_file "app/models/post.rb", "  subscribe :UserNotifier\n  subscribe :PostNotifier\n  subscribe :UserMailer\n  subscribe :PostMailer\n", before: "end"

# Generate ActiveModel Model
file "app/models/register.rb", <<~CODE
  class Register
    include ActiveModel::Model
    include PubsubNotifier::Proxy

    subscribe :UserNotifier
    subscribe :PostNotifier
    subscribe :UserMailer
    subscribe :PostMailer
  end
CODE

run "rm -r spec"

rake "db:migrate"
