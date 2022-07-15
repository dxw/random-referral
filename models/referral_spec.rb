require_relative "./referral"

RSpec.describe Referral do
  subject { Referral.new(
    id: "fake_id",
    company: "Fake Company",
    code: "12356789"
  ) }

  describe ".all" do
    before do
      allow(Referral).to receive(:worksheet) {
        OpenStruct.new(rows: [
          ['Who (optional)', 'Service', 'Link / code', 'Include in public site?'],
          ['Person A', 'Service A', 'Code A', 'Y'],
          ['Person B', 'Service B', 'Code B', 'N'],
          ['Person C', 'Service C', 'Code C', 'Y'],
        ])
      }
    end
    it "returns an array of referrals" do
      Referral.all.each do |referral|
        expect(referral).to be_instance_of(Referral)
      end
    end

    context "when someone has opted in" do
      it "includes their referral code" do
        all_referrals = Referral.all
        all_referral_codes = all_referrals.map(&:code)
        expect(all_referral_codes).to include("Code A")
      end
    end

    context "when someone has not opted in" do
      it "includes their referral code" do
        all_referrals = Referral.all
        all_referral_codes = all_referrals.map(&:code)
        expect(all_referral_codes).not_to include("Code B")
      end
    end
  end

  describe "#id" do
    it "returns the id" do
      expect(subject.id).to eql("fake_id")
    end
  end

  describe "#company" do
    it "returns the company" do
      expect(subject.company).to eql("Fake Company")
    end
  end

  describe "#code" do
    it "returns the code" do
      expect(subject.code).to eql("12356789")
    end
  end
end