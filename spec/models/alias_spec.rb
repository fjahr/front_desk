require 'rails_helper'

RSpec.describe Alias, type: :model do
  let(:member) { FactoryGirl.create(:member) }
  let(:attr) { {member_id: member.id, name: "John Doe"} }

  subject { Alias.new(attr) }

  describe "with a name and a member association" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  describe "without a name" do
    let(:attr) { {member_id: 1, name: nil} }

    it "should not be valid" do
      expect(subject).not_to be_valid
    end
  end

  describe "without a member association" do
    let(:attr) { {member_id: nil, name: "John Doe"} }

    it "should not be valid" do
      expect(subject).not_to be_valid
    end
  end
end
