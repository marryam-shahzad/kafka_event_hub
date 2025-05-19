# lib/kafka_event_hub/producer.rb

module KafkaEventHub
  class Producer < Config
    def initialize(topic = nil)
      super('producer' => true, 'topic' => topic)
    end

    # Produce any message to Kafka
    def produce(topic: nil, key:, payload:, partition: nil)
      real_topic = topic || @topic
      producer   = @kafka.producer
      json       = payload.is_a?(String) ? payload : payload.to_json

      producer.produce(
        topic:     real_topic,
        key:       key,
        payload:   json,
        partition: partition
      ).wait
    ensure
      producer&.close
    end
  end
end
