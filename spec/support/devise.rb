# frozen_string_literal: true

require 'devise/jwt/test_helpers'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :view
end
