module PubsubNotifier
  class Railtie < ::Rails::Railtie
    initializer "pubsub_notifier" do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send :include, ::PubsubNotifier::Proxy
      end

      ActiveSupport.on_load :active_job do
        require "pubsub_notifier/broadcasters/active_job_broadcaster"
      end

      ActiveSupport.on_load :action_mailer do
        require "pubsub_notifier/acts_as_notifier"
        ActionMailer::Base.send :include, PubsubNotifier::ActsAsNotifier
      end
    end
  end
end
