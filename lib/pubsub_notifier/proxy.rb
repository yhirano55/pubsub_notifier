module PubsubNotifier
  module Proxy
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def subscribe(subscriber_name, options = {})
        subscriber  = subscriber_name.to_s.constantize
        broadcaster = (options.delete(:async) ? broadcasters[:async] : nil) || broadcasters[:default]
        broadcaster.configure(options) if broadcaster.respond_to?(:configure)
        pubsub.subscribe(subscriber, broadcaster: broadcaster)
      end

      def pubsub
        @_pubsub ||= ::PubsubNotifier::Pubsub.new
      end

      private

        def broadcasters
          Wisper.configuration.broadcasters
        end
    end

    def broadcast(event)
      pubsub.call(event, self)
    end

    alias_method :pubilish, :broadcast

    private

      def pubsub
        self.class.pubsub
      end
  end
end
