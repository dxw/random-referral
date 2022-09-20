require "rails_helper"

RSpec.describe Referral, type: :model do
  subject {
    Referral.new(
      code: "12356789"
    )
  }

  describe "#code" do
    it "returns a code" do
      expect(subject.code).to eql("12356789")
    end
  end

  describe ".all" do
    before do
      allow(Referral).to receive(:worksheet) {
        OpenStruct.new(rows: [
          ["Who (optional)", "Service", "Link / code", "Include in public site?"],
          ["Sam", "Service 1", "Code for Sam", "Y"],
          ["Mas", "Service 1", "Code for Mas", "Y"],
          ["", "Service 1", "Code for unknown", "Y"],
          ["Sam", "Service 2", "Code for Sam", "Y"],
          ["Bob", "", "Code for Bob", "Y"],
          ["", "", "Code for double unknown", "Y"],
          ["Alice", "Service 3", "Code for Alice", ""],
          ["Charlie", "Service 4", "Code for Charlie", "N"]
        ])
      }
    end

    it "returns an array of Referrals" do
      Referral.all.each do |referral|
        expect(referral).to be_instance_of(Referral)
      end
    end

    it "creates a Referral for a row of the worksheet" do
      allow(Referral).to receive(:new)
      Referral.all
      expect(Referral).to have_received(:new).with(code: "Code for Bob")
    end

    it "only returns referrals which have opted in to be public" do
      referrals = Referral.all
      expect(referrals.count).to eq(6)
      expect(referrals).not_to include(an_object_having_attributes(code: "Code for Alice"))
      expect(referrals).not_to include(an_object_having_attributes(code: "Code for Charlie"))
    end
  end

  describe ".random" do
    let(:referrals) {
      [
        Referral.new(code: "code_1"),
        Referral.new(code: "code_2")
      ]
    }
    before do
      allow(Referral).to receive(:all).and_return(referrals)
    end

    it "returns a random referral" do
      expected_referral = Referral.new(code: "random_code")
      expect(referrals).to receive(:sample).and_return(expected_referral)

      random_referral = Referral.random

      expect(random_referral).to be(expected_referral)
    end
  end
end
