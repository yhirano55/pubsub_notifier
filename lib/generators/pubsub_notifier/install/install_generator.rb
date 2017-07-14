module PubsubNotifier
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def create_initializer_file
        template "initializer.tt", "config/initializers/pubsub_notifier.rb"
      end

      def create_application_notifier_file
        template "application_notifier.tt", "app/notifiers/application_notifier.rb"
      end
    end
  end
end
