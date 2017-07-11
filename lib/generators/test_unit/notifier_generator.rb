module TestUnit
  class NotifierGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)

    def create_spec_file
      template 'notifier_test.rb', File.join('test/notifiers', class_path, "#{file_name}_notifier_test.rb")
    end
  end
end
