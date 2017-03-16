require 'rails_helper'

RSpec.describe Visit, type: :model do
  subject { described_class.new(attr) }

  let(:attr) {
    {
      account: account,
    }
  }

  let(:account) { FactoryGirl.create(:account) }

  describe "with all valid attributes" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  ["account"].each do |val|
    describe "without #{val}" do
      let(:"#{val}") { nil }

      it "should not be valid" do
        expect(subject).to_not be_valid
      end
    end
  end


end
