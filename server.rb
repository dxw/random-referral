require 'csv'
require 'google_drive'
require 'sinatra'
require 'dotenv/load'

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
  # Replace this with GoogleDrive::Session.from_access_token using a token from
  # an environment variable. We'll need to get an access token for that. We could
  # do OAuth ourselves, or we could find out where GoogleDrive caches the access
  # token between executions and grab it from there. We're struggling to find out
  # where the access token is saved, though.
  session = GoogleDrive::Session.from_config('.data/gsuite-auth-config.json')
  worksheet = session.spreadsheet_by_key(ENV['SPREADSHEET_ID']).worksheets[0]

  worksheet.rows
    .select { |row|
      # only use links from folks who've opted in
      row[3] == 'Y'
    }.map { |row|
      # columns are zero-indexed
      OpenStruct.new(
        # company: OpenStruct.new(id: row[1].gsub(" ", "_").downcase, name: row[1]),
        id: row[1].gsub(" ", "_").downcase,
        company: row[1],
        code: row[2],
      )
    }
end

def companies
  referrals.map(&:company)
end

def referrals_by_company_id(id:)
  referrals.select{|referral| referral.id == params["company_id"]}
end
