require 'csv'
require 'sinatra'
require 'dotenv/load'
require_relative 'models/referral'

get '/', :provides => 'html' do
  unique_companies = referrals.map{|referral| {id: referral.id, text: referral.company }}.uniq
  # unique_companies = referrals.map{&:company}.uniq

  erb :choose_a_company, :layout => :layout, :locals => { :unique_companies => unique_companies }
end

get '/code', :provides => 'html' do
  relevant_referrals = referrals_by_company_id(id: params["company_id"])
  random_referral = relevant_referrals.sample
  code = random_referral.code

  erb :referral_code, :layout => :layout, :locals => { :code => code }
end

def referrals
  Referral.all
end

def companies
  referrals.map(&:company)
end

def referrals_by_company_id(id:)
  referrals.select{|referral| referral.id == params["company_id"]}
end
