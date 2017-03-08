module Webhooks
  module Stripe
    class ChargeSucceeded
      def call(event)
        charge = event.data.object

        account = Account.find_by(stripe_id: charge.customer)
        charge = account.charges.where(stripe_id: charge.id).first_or_create

        charge.update(
          amount: charge.amount,
          card_brand: charge.source.brand,
          card_last4: charge.source.last4,
          card_exp_month: charge.source.exp_month,
          card_exp_year: charge.source.exp_year
        )
      end
    end
  end
end
