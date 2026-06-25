require "rails_helper"
require "pact/rspec"

RSpec.describe "laa-apply-for-legal-aid pact",
               :pact,
               :pact_entity => :provider do

  http_pact_provider "legal-framework-api", opts: {
    # The application under test. This is the application that will be mounted by Web server started by Pact to verify the pacts.
    app: Rails.application,

    # start rackup with a different port. Useful if you already have something running on the default port *9292*
    http_port: 9393,

    # Set the logger and  log level, default is :info, and cannot be changed unless you specify a logger
    logger: Rails.logger,
    log_level: :warn,

    fail_if_no_pacts_found: true,

    # pact_uri: "#{ENV.fetch("PACT_BROKER_BASE_URL", "https://not-a-real-pact-broker.service.gov.uk")}/pacts/providers/legal-framework-api/consumers/laa-apply-for-legal-aid/latest",
    pact_uri: "spec/pacts/laa-apply-for-legal-aid-legal-framework-api.json", # for local testing, use a local pact file instead of downloading from the broker
    broker_token: ENV.fetch("PACT_BROKER_TOKEN", 'some-token')
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
