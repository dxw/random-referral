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
end
