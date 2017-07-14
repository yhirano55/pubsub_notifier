module TestUnit
  module Generators
    class NotifierGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def create_test_file
        template "notifier_test.tt", File.join("test/notifiers", class_path, "#{file_name}_notifier_test.rb")
      end
    end
  end
end
