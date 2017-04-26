require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ExpenseTracker
  class Application < Rails::Application
    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end

    config.time_zone = "Central Time (US & Canada)"
    config.active_record.default_timezone = :local

    config.active_record.raise_in_transactional_callbacks = true
  end
end
