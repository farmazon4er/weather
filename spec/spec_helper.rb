require 'rubygems'

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: %r{spec/api}
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

require 'capybara/rspec'
