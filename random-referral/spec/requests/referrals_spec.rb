require "rails_helper"

RSpec.describe "Referrals", type: :request do
  let(:referrals) {
    [
      Referral.new(id: "id-one", code: "code_1"),
      Referral.new(id: "id-two", code: "code_2")
    ]
  }
  before do
    allow(Referral).to receive(:all).and_return(referrals)
  end

  describe "GET /referrals/:id" do
    it "renders a code" do
      get "/referrals/id-one"
      expect(response.body).to include("data-testid=\"referral-code\"")
    end

    it "renders the correct code" do
      get "/referrals/id-two"
      expect(response.body).to include("code_2")
    end
  end

  describe "GET /random" do
    it "does a redirect" do
      get "/random"
      expect(response.status).to eql(302)
    end

    it "redirects to a referral url" do
      get "/random"
      expect(response.header["Location"]).to match(/^\w+:\/\/[\w.]+\/referrals\/[\w-]+$/)
    end
  end
end
