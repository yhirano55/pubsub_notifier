module PubsubNotifier
  module Client
    class Base
      def self.configure
        yield config
      end

      def self.config
        @_config ||= self::Config.new
      end

      def initialize(options = {})
      end

      def notify_success(message)
        raise NotImplementedError, "#{self.class}##{__method__} is not implemented"
      end

      def notify_failure(message)
        raise NotImplementedError, "#{self.class}##{__method__} is not implemented"
      end

      private

        def logger
          PubsubNotifier.config.logger
        end

        def config
          self.class.config
        end
    end

    class LoggerClient < Base
      def notify_success(message)
        logger.debug { "[#{self.class}##{__method__}] #{message}" }
      end

      def notify_failure(message)
        logger.debug { "[#{self.class}##{__method__}] #{message}" }
      end
    end
  end
end
