module PubsubNotifier
  module Broadcasters
    class Base
      attr_accessor :options

      def initialize
        @options = {}
      end

      def configure(opts = {})
        self.options = default_options.merge(opts).reject { |_, v| v.nil? }.each_with_object({}) do |(key, proc_or_value), result|
          result[key] = proc_or_value.is_a?(Proc) ? proc_or_value.call : proc_or_value
        end
      end

      def broadcast(subscriber, publisher, event, *args)
        raise NotImplementedError
      end

      private

        def logger
          PubsubNotifier.config.logger
        end

        def default_options
          {}
        end
    end
  end
end
