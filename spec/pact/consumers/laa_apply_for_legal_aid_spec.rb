require "rails_helper"
require "pact/rspec"

# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe "laa-apply-for-legal-aid pact",
               :pact,
               pact_entity: :provider do
  http_pact_provider "legal-framework-api", opts: {
    # The application under test. This is the application that will be mounted by Web server started by Pact to verify the pacts.
    app: Rails.application,

    # start rackup with a different port. Useful if you already have something running on the default port *9292*
    http_port: 9393,

    # Set the logger and  log level, default is :info, and cannot be changed unless you specify a logger
    logger: Rails.logger,
    log_level: :info,

    fail_if_no_pacts_found: true,

    # for local testing, use a local pact file copied from a consumer to the `spec/pacts` directory, instead of downloading from
    # the broker, and uncomment the pact_uri and pact_dir lines, and comment out the broker_url config below.
    #
    # pact_uri: "spec/pacts/laa-apply-for-legal-aid-legal-framework-api.json",
    # pact_dir: "spec/pacts",

    # Use this when you want the verifier to query a Pact Broker and discover pacts automatically.
    broker_url: ENV.fetch("PACT_BROKER_BASE_URL", nil),
    broker_username: ENV.fetch("PACT_BROKER_USERNAME", nil),
    broker_password: ENV.fetch("PACT_BROKER_PASSWORD", nil),
    publish_verification_results: true,
    provider_version: ENV.fetch("PROVIDER_VERSION", "latest"),
  }

  # NOTE: rails_helper seeds all data, so state setup not needed,
  # but custom state setup can be done here per "interaction"
  # defined in the pact file if needed, for example:
  #
  # provider_state "countries exist" do
  #   setup do
  #     # create a country
  #     FactorBot.create(:country, code: "GBR", description: "United Kingdom")
  #   end
  #
  #   teardown do
  #     # clean up any data created in the setup block
  #   end
  # end
end
# rubocop:enable RSpec/EmptyExampleGroup
