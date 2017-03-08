Stripe.api_key = Rails.application.secrets.stripe_private_key

StripeEvent.configure do |events|
  events.subscribe "charge.succeeded", Webhooks::Stripe::ChargeSucceeded.new
end
