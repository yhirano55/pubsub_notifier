module PubsubNotifier
  module ActsAsNotifier
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def acts_as_notifier
        class_eval do
          class << self
            private

              # Override ActionMailer::Base#method_missing
              # https://github.com/rails/rails/blob/master/actionmailer/lib/action_mailer/base.rb#L576
              def method_missing(method_name, *args)
                if action_methods.include?(method_name.to_s)
                  ::ActionMailer::MessageDelivery.new(self, method_name, *args).tap(&:deliver)
                else
                  super
                end
              end

              def respond_to_missing?(method_name, include_all = false)
                action_methods.include?(method_name.to_s) || super
              end
          end
        end
      end
    end
  end
end
