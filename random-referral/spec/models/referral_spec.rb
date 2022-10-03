require "rails_helper"

RSpec.describe Referral, type: :model do
  subject {
    Referral.new(
      code: "12356789",
      service_provider: "Test Service Prov.ider"
    )
  }

  describe "#id" do
    it "returns a generated id" do
      expected_id = Digest::SHA2.hexdigest("Test Service Prov.ider ::: 12356789")

      expect(subject.id).to eql(expected_id)
    end
  end

  describe "#code" do
    it "returns a code" do
      expect(subject.code).to eql("12356789")
    end
  end

  describe "#service_provider" do
    it "returns a service provider" do
      expect(subject.service_provider).to eql("Test Service Prov.ider")
    end
  end

  describe "#service_provider_id" do
    it "replaces non word characters in #service_provider with underscores" do
      expect(subject.service_provider_id).to eql("test-service-prov-ider")
    end
  end

  describe ".all" do
    before do
      allow(Referral).to receive(:worksheet) {
        OpenStruct.new(rows: [
          ["Who (optional)", "Service", "Link / code", "Include in public site?"],
          ["Sam", "Service 1", "Code for Sam", "Y"],
          ["Mas", "Service 1", "Code for Mas", "Y"],
          ["", "Service 1", "Code for unknown 1", "Y"],
          ["", "Service 1", "Code for unknown 2", "Y"],
          ["Sam", "Service 2", "Code for Sam", "Y"],
          ["Bob", "", "Code for Bob 1", "Y"],
          ["Bob", "", "Code for Bob 2", "Y"],
          ["", "", "Code for double unknown 1", "Y"],
          ["", "", "Code for double unknown 2", "Y"],
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

      expect(Referral).to have_received(:new).with(code: "Code for Mas", service_provider: "Service 1")
    end

    it "only returns referrals which have opted in to be public" do
      referrals = Referral.all
      expect(referrals.count).to eq(9)
      expect(referrals).not_to include(an_object_having_attributes(code: "Code for Alice"))
      expect(referrals).not_to include(an_object_having_attributes(code: "Code for Charlie"))
    end

    it "returns Referrals with unique ids" do
      referrals = Referral.all
      referral_ids = referrals.map(&:id)
      expect(referral_ids.uniq).to eq(referral_ids)
    end
  end

  describe ".random" do
    let(:referrals) {
      [
        Referral.new(code: "code_1", service_provider: "Service 1"),
        Referral.new(code: "code_2", service_provider: "Service 2")
      ]
    }
    before do
      allow(Referral).to receive(:all).and_return(referrals)
    end

    it "returns a random referral" do
      expected_referral = Referral.new(code: "random_code", service_provider: "random_service")
      expect(referrals).to receive(:sample).and_return(expected_referral)

      random_referral = Referral.random

      expect(random_referral).to be(expected_referral)
    end
  end
end
