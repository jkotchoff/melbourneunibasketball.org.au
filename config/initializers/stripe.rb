Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_MUBC_PUBLISHABLE_KEY_TEST'],
  secret_key: ENV['STRIPE_MUBC_SECRET_KEY_TEST']
}

Stripe.api_key = ENV['STRIPE_MUBC_SECRET_KEY_TEST']
