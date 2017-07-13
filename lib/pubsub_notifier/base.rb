module PubsubNotifier
  class Base
    class << self
      def use(name, options = {})
        @_client = (clients[name.to_sym] || clients[:logger]).new(options)
      end

      def client
        @_client ||= clients[:logger].new
      end

      private

        def clients
          PubsubNotifier.config.clients
        end

        def method_missing(method_name, *args, &block)
          super unless public_instance_methods.include?(method_name.to_sym)
          new.public_send(method_name, *args, &block)
        end

        def respond_to_missing?(method_name, include_private = false)
          public_instance_methods.include?(method_name.to_sym) || super
        end
    end

    private

      def client
        self.class.client
      end

      def method_missing(method_name, *args, &block)
        super unless client.respond_to?(method_name.to_sym)
        client.public_send(method_name, *args, &block)
      end

      def respond_to_missing?(method_name, include_private = false)
        client.respond_to?(method_name.to_sym) || super
      end
  end
end
