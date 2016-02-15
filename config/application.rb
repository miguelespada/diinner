require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

ENV.update YAML.load_file('config/mapbox.yml')[Rails.env] rescue {}
PRICES_RANGES = YAML.load_file('config/price_ranges.yml')

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dinner
  class Application < Rails::Application
    # Mongoid.logger.level = Logger::ERROR
    # Mongo::Logger.level = Logger::ERROR
    Mongoid.logger.level = Logger::DEBUG
    Mongo::Logger.level = Logger::DEBUG

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :es
    config.i18n.fallbacks = true
    config.i18n.fallbacks = {'es' => 'en'}
    config.time_zone = 'Europe/Madrid'

    # heroku config:add TZ="Europe/Madrid"
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end


  end
end


require "attachinary/orm/mongoid"

