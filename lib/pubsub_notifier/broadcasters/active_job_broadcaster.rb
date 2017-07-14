module PubsubNotifier
  module Broadcasters
    class ActiveJobBroadcaster < Base
      def broadcast(subscriber, publisher, event, *args)
        configured_job.perform_later(subscriber.name, event, args)
      rescue ActiveJob::SerializationError => e
        # NOTE: Fallback if global_id is blank
        logger.warn { e.inspect }
        configured_job.perform_now(subscriber.name, event, *args)
      end

      private

        def configured_job
          BroadcastJob.set(options)
        end

        def default_options
          { wait: nil, wait_until: nil, queue: :default }
        end

        class BroadcastJob < ::ActiveJob::Base
          def perform(subscriber_name, event, args)
            subscriber = subscriber_name.constantize
            subscriber.public_send(event, *args)
          end
        end
    end
  end
end

PubsubNotifier.register_broadcaster :async, PubsubNotifier::Broadcasters::ActiveJobBroadcaster
