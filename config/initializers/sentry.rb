# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    config.dsn = 'https://654c636e6f9b742eaa09a7bbdcab37a2@o4508042417930240.ingest.us.sentry.io/4508042419306496'
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for tracing.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0
    # Set profiles_sample_rate to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    config.profiles_sample_rate = 1.0
  end
end
