require 'uri'
require 'infrataster/rspec'

Infrataster::Server.define(
  :nginx,
  URI.parse(ENV['DOCKER_HOST']).host,
)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
