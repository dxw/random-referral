class ReferralsController < ApplicationController
  def index_by_service_provider
    @service_providers = Referral.all.map { |referral|
      {id: referral.service_provider_id, name: referral.service_provider}
    }.uniq.sort_by { |service_provider| service_provider[:name].downcase }
  end

  def show
    @referral = Referral.all.find do |referral|
      referral.id == params[:id]
    end
  end

  def random
    @referral = Referral.random(service_provider_id: params[:service_provider])
    redirect_to referral_path(id: @referral.id)
  end
end
