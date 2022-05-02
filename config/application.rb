require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FriendlyOctoTribble
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
		
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
		
		# Permitted locales available for the application
		config.i18n.available_locales = [:en, :pl]
		
		# Set default locale to something other than :en
		config.i18n.default_locale = :en
		
		# Fallback locale for translations
		config.i18n.fallbacks = true
  end
end
