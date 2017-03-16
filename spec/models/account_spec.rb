require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { described_class.new(attr) }

  describe "Account without a user" do
    let(:attr) { {} }

    it "is not valid" do
      expect(subject).to_not be_valid
    end
  end

  describe "Account with a user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:attr) { {user: user} }

    it "is valid" do
      expect(subject).to be_valid
    end
  end

end
