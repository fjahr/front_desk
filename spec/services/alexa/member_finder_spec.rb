require 'rails_helper'

RSpec.describe MemberFinder do
  let(:account) { FactoryGirl.create(:account) }
  let(:given_name) { "erlich" }

  subject { described_class.find(given_name) }

  describe "with no member in db" do
    it "should be nil" do
      expect(subject).to eq(nil)
    end
  end

  describe "with members in db" do
    let!(:member) { FactoryGirl.create(:member, account: account, name: member_name) }

    context "given name is exact match to member name" do
      let(:member_name) { "erlich" }
      let(:given_name) { "erlich" }

      it "should be found" do
        expect(subject).to eq(member)
      end
    end

    context "given name is case insesitive" do
      let(:member_name) { "erlich" }
      let(:given_name) { "Erlich" }

      it "should be found" do
        expect(subject).to eq(member)
      end
    end

    context "member name is case insesitive" do
      let(:member_name) { "Erlich" }
      let(:given_name) { "erlich" }

      it "should be found" do
        expect(subject).to eq(member)
      end
    end

    describe "and with aliases in db" do
      let!(:alias) { FactoryGirl.create(:alias, member: member, name: alias_name) }

      context "where alias name is exact match" do
        let(:member_name) { "Erhard" }
        let(:given_name) { "erlich" }
        let(:alias_name) { "erlich" }

        it "should be found" do
          expect(subject).to eq(member)
        end
      end

      context "where alias name is case insensitive match" do
        let(:member_name) { "Erhard" }
        let(:given_name) { "Erlich" }
        let(:alias_name) { "erlich" }

        it "should be found" do
          expect(subject).to eq(member)
        end
      end

      context "where given name is case insensitive match" do
        let(:member_name) { "Erhard" }
        let(:given_name) { "erlich" }
        let(:alias_name) { "Erlich" }

        it "should be found" do
          expect(subject).to eq(member)
        end
      end
   end
  end
end

