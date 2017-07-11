module Rails
  module Generators
    class NotifierGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def create_notifier_file
        template 'notifier.rb', File.join('app/notifiers', class_path, "#{file_name}_notifier.rb")
      end

      hook_for :test_framework
    end
  end
end
