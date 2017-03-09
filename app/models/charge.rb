class Charge < ApplicationRecord
  belongs_to :account
  validates :stripe_id, uniqueness: true

  def receipt
    Receipts::Receipt.new(
      id: stripe_id,
      product: "Alexa Front Desk",
      company: {
        name: "Alexa Front Desk - Fabian Jahr",
        address: "Heinrich-Heine-Platz 12, 10179 Berlin, Germany",
        email: "support@alexafrontdesk.com"
                #logo: Rails.root.join("app/assets/images/one-month-dark.png") 
      },
      line_items: [
        ["Date",           created_at.to_s],
        ["Account Billed", "#{account.email}"],
        ["Subscription",   ""],
        ["Amount",         ActionController::Base.helpers.number_to_currency(amount / 100)],
        ["Charged to",     "#{card_brand} (**** **** **** #{card_last4})"],
      ]
    )
  end
end
