require "rails_helper"

RSpec.describe Referral, type: :model do
  describe "#code" do
    it "returns a string" do
      expect(subject.code).to be_a(String)
    end
  end
end
