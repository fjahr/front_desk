FactoryGirl.define do
  factory :charge do
    account nil
    stripe_id "MyString"
    amount 1
    card_brand "MyString"
    card_last4 "MyString"
    card_exp_month "MyString"
    card_exp_year "MyString"
  end
end
