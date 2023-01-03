# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://a7bddd0ae02b46569c7a814e7ad57afb@o4504339358482432.ingest.sentry.io/4504339359662080'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
