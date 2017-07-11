require "logger"

module PubsubNotifier
  class Config
    attr_accessor :logger
    attr_reader :clients

    def initialize
      @logger  = Logger.new(STDOUT)
      @clients = {}
    end
  end
end
