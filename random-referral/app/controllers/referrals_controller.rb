class ReferralsController < ApplicationController
  def show
    @referral = Referral.new
  end
end
