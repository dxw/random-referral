class ReferralsController < ApplicationController
  def show
    @referral = Referral.all.find do |referral|
      referral.id == params[:id]
    end
  end

  def random
    @referral = Referral.random
    redirect_to referral_path(id: @referral.id)
  end
end
