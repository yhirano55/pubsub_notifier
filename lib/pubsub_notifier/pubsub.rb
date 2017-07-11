module PubsubNotifier
  class Pubsub
    include Wisper::Publisher

    def call(event, *args)
      broadcast(event, *args)
    end
  end
end
