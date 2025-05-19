# lib/kafka_event_hub/consumer.rb
module KafkaEventHub
  class Consumer < Config
    def initialize(topic = nil)
      super('consumer' => true, 'topic' => topic)
    end

    # Generic message consuming loop - pass a block to process messages
    def each_message
      consumer = @kafka.consumer
      consumer.subscribe(@topic)

      consumer.each do |message|
        yield message
      end
    ensure
      consumer&.close
    end

    # Optional: poll with timeout
    def poll_messages(timeout = POLL_TIMEOUT)
      consumer = @kafka.consumer
      consumer.subscribe(@topic)

      loop do
        message = consumer.poll(timeout)
        break unless message

        yield message
      end
    ensure
      consumer&.close
    end
  end
end
