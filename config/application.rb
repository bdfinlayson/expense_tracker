require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ExpenseTracker
  class Application < Rails::Application
    config.generators do |g|
      g.fixture_replacement :factory_girl
    end

    config.active_record.raise_in_transactional_callbacks = true
  end
end
