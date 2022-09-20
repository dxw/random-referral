require "rails_helper"

RSpec.describe "Referrals", type: :request do
  let(:referrals) {
    [
      Referral.new(code: "code_1"),
      Referral.new(code: "code_2")
    ]
  }
  before do
    allow(Referral).to receive(:all).and_return(referrals)
  end

  describe "GET /referrals/:id" do
    it "renders a code" do
      get "/referrals/1"
      expect(response.body).to include("data-testid=\"referral-code\"")
    end
  end
end
