class ReferralsController < ApplicationController
  def show
    @referral = Referral.random
  end
end
