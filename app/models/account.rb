class Account < ApplicationRecord
  belongs_to :user
  has_many :members
  has_many :charges
  has_many :visits
  has_many :aliases, through: :members

  validates :user, presence: true

  def stripe_customer
    Stripe::Customer.retrieve(stripe_id)
  end

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

  def never_subscribed?
    !stripe_subscription_id?
  end

  def expired?
    expires_at? && Time.zone.now > expires_at
  end
end

class MissingTokenError < StandardError; end
