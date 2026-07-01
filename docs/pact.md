# Pact - consumer driven testing

## References
- [Pact version 2 readme](https://docs.pact.io/implementation_guides/ruby/readme_v2)
- [Pact specification versions](https://docs.pact.io/implementation_guides/pact_specification#specification-documentation)
- [Pact specification repo](https://github.com/pact-foundation/pact-specification)
- [Pact broker repo](https://github.com/ministryofjustice/laa-data-pact-broker)
- [Pact brocker host](https://laa-data-pact-broker.apps.live.cloud-platform.service.justice.gov.uk/)
- [Pact broker webhooks](https://laa-data-pact-broker.apps.live.cloud-platform.service.justice.gov.uk/hal-browser/browser.html#https://laa-data-pact-broker.apps.live.cloud-platform.service.justice.gov.uk/webhooks)
- [Pact webhook service verification](https://github.com/apps/laa-java-service-deployer/installations/44250102)


## What is pact
Pact provides a standard convention base specification for writing and using contract tests. We use consumer
driven contract testing where the provider, legal-framework-api, must verify it can meet or continue to meet
the behaviour expected of it by the consumer.

The high-level flow pact base flow

- The consumer generates a contract or contracts
- The consumer publishes the contract(s) to a broker/middleman
- The provider or providers retrieve the contract(s) from the broker
- The provider(s) verify the contract(s)

### Pipeline integration
When the provider has a PR opened against it on github the `pact.yml` github action will verify that it meets the latest contract(s) published by all consumers on [the pact brocker](https://laa-data-pact-broker.apps.live.cloud-platform.service.justice.gov.uk/). It will will specify the "provider version" using the github sha of the last commit.

To access the consumer contract from the pact broker the github action has been provided with 3 secrets. These are set in Github > Settings > Secrets and variables > Actions. The secrets values are available from the teams password manager.

```sh
PACT_BROKER_BASE_URL
PACT_BROKER_USERNAME
PACT_BROKER_PASSWORD
```

#### Triggering provider verification from pipeline of consumer

The providers github action is configured to be triggered by the pact broker via a web hook in the brokers repo. For example this is [legal-frameowork-apis webhook configuration](https://github.com/ministryofjustice/laa-data-pact-broker/blob/main/seed/webhook-legal-framework-api.json).

There is also a "Github App" that must also be granted read and write access to this provider repo - click this [laa-java-service-deployer](https://github.com/apps/laa-java-service-deployer/installations/44250102) and select the repo you wish to grant it access to. This allows the selected repos GHAs to be be triggered by another repo.


## Local testing

### Local testing without a broker
To test a consumer contract locally without using a broker you should

- Copy a contract from the consumer to the `pacts/` directory. *This directory is .gitignore'd*
- Temporarily amend the verification spec, such as `pact/consumers/laa_apply_for_legal_aid_spec.rb`, to comment out the broker related config and uncomment the local pact related config.

```ruby
  # for local testing, use a local pact file copied from a consumer to the `spec/pacts` directory, instead of downloading from
  # the broker, and uncomment the pact_uri and pact_dir lines, and comment out the broker_url config below.
  #
  # UNCOMMENTED FOR LOCAL TESTING
  pact_uri: "spec/pacts/laa-apply-for-legal-aid-legal-framework-api.json",
  pact_dir: "spec/pacts",

  # COMMENTED OUT FOR LOCAT TESTING
  # Use this when you want the verifier to query a Pact Broker and discover pacts automatically.
  # broker_url: ENV.fetch("PACT_BROKER_BASE_URL", nil),
  # broker_username: ENV.fetch("PACT_BROKER_USERNAME", nil),
  # broker_password: ENV.fetch("PACT_BROKER_PASSWORD", nil),
  # publish_verification_results: true,
  # provider_version: ENV.fetch("PROVIDER_VERSION", "latest"),
```

- [Run the verifcation specs](#run-the-verifcation-specs)

### Local testing with a broker
If there is a broker available to which the provider has been granted the relevant privileges (see our [pact broker](https://github.com/ministryofjustice/laa-data-pact-broker)) then you can verify those pacts from your local machine by providing the necessary secrets. These secrets are available in the teams password manager.

```sh
PACT_BROKER_BASE_URL=<see-password-manager>
PACT_BROKER_USERNAME=<see-password-manager>
PACT_BROKER_PASSWORD=<see-password-manager>
```

Place these in the `.env.test` (or `.env`) then [run the verifcation specs](#run-the-verifcation-specs). See below

### Run the verifcation specs

To run all pact verification specs
```sh
bundle exec rails pact:verify
```

You can run individual pact verification specs using the tag `pact`

```sh
bundle exec rspec -t pact spec/pact/consumers/laa_apply_for_legal_aid_spec.rb
```
