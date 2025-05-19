# KafkaEventHub

[![Build Status](https://github.com/marryam-shahzad/kafka_event_hub/actions/workflows/ci.yml/badge.svg)](https://github.com/marryam-shahzad/kafka_event_hub/actions)
[![Gem Version](https://badge.fury.io/rb/kafka_event_hub.svg)](https://badge.fury.io/rb/kafka_event_hub)

KafkaEventHub is a Ruby gem providing a clean, generic, and configurable interface for producing and consuming Kafka messages in Ruby and Rails applications. It abstracts Kafka connection management and offers flexible producer and consumer classes for easy event streaming integration.

---

## Features

- Generic Kafka Producer with topic, key, payload, and partition support.
- Generic Kafka Consumer supporting message polling and subscription.
- Easily configurable via environment variables or programmatically.
- Lightweight and reusable across multiple Ruby or Rails projects.
- Handles message serialization/deserialization seamlessly.
- Retry mechanisms can be implemented externally in jobs or services.

---

## Installation

Add this line to your application's Gemfile:

    gem 'kafka_event_hub'

Then execute:

    bundle install

Or install it yourself as:

    gem install kafka_event_hub

---

## Configuration

Before using the gem, set the following environment variables (adjust as per your Kafka setup):

```bash
DEFAULT_TOPIC=default           # Default Kafka topic
EVENT_HUB_NAMESPACE=your-namespace.servicebus.windows.net:9093
EVENT_HUB_URL="Endpoint=sb://your-namespace.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=your-access-key"
EVENT_HUB_CONSUMER_GROUP=Default
APP_NAME=your-app-name
KAFKA_POLL_TIMEOUT=120000      # in milliseconds
```
---

## Usage

### Producer

Create a producer instance and send messages to Kafka topics easily:

    producer = KafkaEventHub::Producer.new('your-topic')

    producer.produce(
      key: 'Entity#123',
      payload: { event: 'event_name', data: 'your data here', timestamp: Time.now }
    )

### Consumer

Create a consumer instance and process incoming messages with a block:

    consumer = KafkaEventHub::Consumer.new('your-topic')

    consumer.each_message do |message|
      puts "Received message: #{message.payload}"
      # Your message processing logic here
    end

Alternatively, use `poll_messages` with a timeout (in milliseconds):

    consumer.poll_messages(1000) do |message|
      # Process each message here
    end

---

## Integration with Rails Jobs

You can wrap your Kafka producer and consumer in Rails ActiveJobs for background processing and retries.

### Example Producer Job

    class GenericKafkaProducerJob < ActiveJob::Base
      queue_as :kafka_stream

      def perform(key, payload, topic = 'default-topic', partition = 0)
        KafkaEventHub::Producer.new(topic).produce(
          key: key,
          payload: payload,
          partition: partition
        )
      end
    end

Customize the job code to suit your app’s background job system or retry logic.

### Example Consumer Job

    class GenericKafkaConsumerJob < ActiveJob::Base
      queue_as :kafka_consumer

      def perform(topic = 'default-topic')
        consumer = KafkaEventHub::Consumer.new(topic)

        consumer.each_message do |message|
          payload = JSON.parse(message.payload)
          # Process your payload here
        end
      end
    end

---

## Development

To set up the development environment:

    bundle install
    rake spec

To build and install the gem locally:

    gem build kafka_event_hub.gemspec
    gem install ./kafka_event_hub-0.1.0.gem

To release a new version:

1. Update the version in `lib/kafka_event_hub/version.rb`.
2. Run:

   bundle exec rake release

This will create a git tag, push commits and tags, and push the gem to [RubyGems.org](https://rubygems.org).

---

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/marryam-shahzad/kafka_event_hub).  
Please follow the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

---

## License

This gem is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---

## Code of Conduct

Everyone participating in this project is expected to follow the [code of conduct](https://github.com/marryam-shahzad/kafka_event_hub/blob/master/CODE_OF_CONDUCT.md).
