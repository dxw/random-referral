class ReferralsController < ApplicationController
  def show
    @referral = Referral.new(code: "code")
  end
end
