require 'rails_helper'

RSpec.describe Charge, type: :model do
  subject { described_class.new(attr) }

  let(:attr) {
    {
      stripe_id: stripe_id,
      account: account,
      amount: amount,
      card_brand: card_brand,
      card_last4: card_last4,
      card_exp_month: card_exp_month,
      card_exp_year: card_exp_year
    }
  }

  let(:stripe_id) { "1234" }
  let(:account) { FactoryGirl.create(:account) }
  let(:amount) { "1000" }
  let(:card_brand) { "Visa" }
  let(:card_last4) { "9999" }
  let(:card_exp_month) { "9" }
  let(:card_exp_year) { "2099" }

  describe "charge with all valid attributes" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  ["account", "amount", "stripe_id", "card_brand", "card_last4", "card_exp_month", "card_exp_year"].each do |val|
    describe "without #{val}" do
      let(:"#{val}") { nil }

      it "should not be valid" do
        expect(subject).to_not be_valid
      end
    end
  end

end
