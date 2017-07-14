module Rspec
  module Generators
    class NotifierGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def create_spec_file
        template "notifier_spec.tt", File.join("spec/notifiers", class_path, "#{file_name}_notifier_spec.rb")
      end
    end
  end
end
