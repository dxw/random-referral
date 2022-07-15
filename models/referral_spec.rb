require_relative "./referral"

RSpec.describe Referral do
  subject { Referral.new(
    id: "fake_id",
    company: "Fake Company",
    code: "12356789"
  ) }

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