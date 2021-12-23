require_relative "boot"
require_relative '../app/middlewares/custom_request_logger'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.eager_load_paths << Rails.root.join("app/validations")

    config.eager_load_paths << Rails.root.join("app/services")

    config.eager_load_paths << Rails.root.join("app/interactors")

    config.eager_load_paths << Rails.root.join("app/value_objects")

    config.eager_load_paths << Rails.root.join("app/forms")

    config.active_job.queue_adapter = :sidekiq

    config.middleware.use Middlewares::CustomRequestLogger
  end
end
