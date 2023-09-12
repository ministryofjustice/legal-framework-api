# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LegalFrameworkApi
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

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.x.status.build_date = ENV["BUILD_DATE"] || "Not Available"
    config.x.status.build_tag = ENV["BUILD_TAG"] || "Not Available"
    config.x.status.app_branch = ENV["APP_BRANCH"] || "Not Available"
    config.x.ccms_soa.aws_gateway_api_key = ENV.fetch("CCMS_SOA_AWS_GATEWAY_API_KEY", nil)
    config.x.ccms_soa.client_username = ENV.fetch("CCMS_SOA_CLIENT_USERNAME", nil)
    config.x.ccms_soa.client_password_type = ENV.fetch("CCMS_SOA_CLIENT_PASSWORD_TYPE", nil)
    config.x.ccms_soa.client_password = ENV.fetch("CCMS_SOA_CLIENT_PASSWORD", nil)
    config.x.ccms_soa.user_role = ENV.fetch("CCMS_SOA_USER_ROLE", nil)
    config.x.ccms_soa.getCommonOrgServiceWsdl = ENV.fetch("CCMS_SOA_GET_COMMON_ORG_WSDL", "GetCommonOrgDEVWsdl.xml")
    config.x.ccms_soa.provider_username = ENV.fetch("CCMS_SOA_PROVIDER_USERNAME", nil)
  end
end
