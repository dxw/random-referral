require "rails_helper"

RSpec.describe "Referrals", type: :request do
  describe "GET /referrals/:id" do
    it "renders a code" do
      get "/referrals/1"
      expect(response.body).to include("data-testid=\"referral-code\"")
    end
  end
end
