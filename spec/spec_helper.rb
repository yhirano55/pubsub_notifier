$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH << File.expand_path("../support", __FILE__)

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)
require "bundler/setup"

ENV["RAILS_ENV"] ||= "test"

require "rails"

ENV["RAILS"] = Rails.version
ENV["RAILS_ROOT"] = File.expand_path("../rails/rails-#{ENV["RAILS"]}", __FILE__)

# Create the test app if it doesn't exists
system "rake setup" unless File.exist?(ENV["RAILS_ROOT"])

# load test app
require ENV["RAILS_ROOT"] + "/config/environment.rb"

# load RSpec
require "rspec/rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
  end

  config.order = :random
  config.use_transactional_fixtures = true
end

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
  end

  factory :post do
    sequence(:name) { |n| "name#{n}" }
  end
end
