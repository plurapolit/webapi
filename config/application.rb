# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Webapi
  class Application < Rails::Application
    config.load_defaults 6.0
    Raven.configure do |config|
      config.dsn = Rails.application.credentials.dig(:sentry_dns)
    end
    # ActiveStorage::Engine.config .active_storage .content_types_to_serve_as_binary .delete('image/svg+xml')
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[delete get post options]
      end
    end
  end
end
