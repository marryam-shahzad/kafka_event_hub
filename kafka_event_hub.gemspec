# kafka_event_hub.gemspec

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kafka_event_hub/version"

Gem::Specification.new do |spec|
  spec.name          = "kafka_event_hub"
  spec.version       = KafkaEventHub::VERSION
  spec.authors       = ["Marryam Shahzad"]
  spec.email         = ["marryamshahzad75@gmail.com"]

  spec.summary       = "Shared Kafka Event Hub configuration for Rails apps"
  spec.description   = <<~DESC
    Centralizes ENV-based Rd-kafka setup into a single gem.
  DESC

  # Once this gem is published, its RubyGems page will be:
  spec.homepage      = "https://rubygems.org/gems/kafka_event_hub"
  spec.license       = "MIT"

  # Only allow pushing to RubyGems.org
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["homepage_uri"]      = spec.homepage
  end

  # Files to include in the gem
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "rdkafka", ">= 0.8"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
end
