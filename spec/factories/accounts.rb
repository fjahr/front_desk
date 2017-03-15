FactoryGirl.define do
  factory :account do
    user

    trait :subscribed do
      stripe_id "123"
      stripe_subscription_id "455"
      card_brand "Visa"
      card_last4 "1234"
      card_exp_month "4"
      card_exp_year "2022"
      expires_at 1.month.from_now
    end
  end
end
