require "active_support/parameter_filter"

Sentry.init do |config|
  config.enabled_environments = %w[production]

  config.breadcrumbs_logger = [:active_support_logger]

  filter = ActiveSupport::ParameterFilter.new(
    Rails.application.config.filter_parameters,
  )

  config.before_send = lambda do |event, _hint|
    filter.filter(event.to_hash)
  end
end
