require 'rails_helper'

RSpec.describe Member, type: :model do
  subject { described_class.new(attr) }

  let(:attr) {
    {
      account: account,
      sequential_id: sequential_id,
      name: name,
      email: email,
      phone: phone,
      slack_id: slack_id,
      hipchat_id: hipchat_id
    }
  }

  let(:account) { FactoryGirl.create(:account) }
  let(:sequential_id) { 1 }
  let(:name) { "Gilfoyle" }
  let(:email) { "gilfoyle@piedpiper.com" }
  let(:phone) { "10101010101" }
  let(:slack_id) { "gilfoyle" }
  let(:hipchat_id) { "gilfoyle" }

  describe "with all valid attributes" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  ["account", "name", "sequential_id"].each do |val|
    describe "without #{val}" do
      let(:"#{val}") { nil }

      it "should not be valid" do
        expect(subject).to_not be_valid
      end
    end
  end

end
