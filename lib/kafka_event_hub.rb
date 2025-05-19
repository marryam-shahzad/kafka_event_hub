require "kafka_event_hub/version"
# lib/kafka_event_hub.rb
require_relative "kafka_event_hub/version"
require_relative "kafka_event_hub/config"
require_relative "kafka_event_hub/producer"
require_relative "kafka_event_hub/consumer"


module KafkaEventHub
  class Error < StandardError; end
  # Your code goes here...
end
