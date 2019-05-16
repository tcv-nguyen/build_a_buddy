require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BuildABuddy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.time_zone = 'Mountain Time (US & Canada)'
    config.eager_load_paths << Rails.root.join('lib')
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
