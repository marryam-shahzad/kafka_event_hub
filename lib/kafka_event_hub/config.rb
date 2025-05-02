# lib/kafka_event_hub/config.rb
require 'rdkafka'

module KafkaEventHub
  class Config
    POLL_TIMEOUT = ENV.fetch('KAFKA_POLL_TIMEOUT', 100).to_i

    def initialize(options = {})
      @topic = options['topic'] || ENV.fetch('DEFAULT_TOPIC', 'default')
      settings = {
        "bootstrap.servers" => ENV.fetch('EVENT_HUB_NAMESPACE'),
        "security.protocol"  => "SASL_SSL",
        "sasl.mechanism"     => "PLAIN",
        "sasl.username"      => "$ConnectionString",
        "sasl.password"      => ENV.fetch('EVENT_HUB_URL'),
        "client.id"          => ENV.fetch('APP_NAME'),
      }
      settings["group.id"] = "$#{ENV['EVENT_HUB_CONSUMER_GROUP']}" if options['consumer']
      @kafka = Rdkafka::Config.new(settings)
    end

    # Returns an Rdkafka Producer
    def producer
      @kafka.producer
    end

    # Returns an Rdkafka Consumer
    def consumer
      @kafka.consumer
    end

    # The default topic to use
    def topic
      @topic
    end
  end
end
