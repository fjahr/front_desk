class Account < ApplicationRecord
  belongs_to :user
  has_many :members

  def stripe_customer_or_new(token)
    if stripe_id.present?
      Stripe::Customer.retrieve(stripe_id)
    else
      raise MissingTokenError unless token.present?

      customer = Stripe::Customer.create(email: user.email, source: token)
      update(stripe_id: customer.id)
      customer
    end
  end

  def subscribed?
    stripe_subscription_id? || (expires_at? && Time.zone.now < expires_at)
  end
end

class MissingTokenError < StandardError; end
