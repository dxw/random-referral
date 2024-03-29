require "google_drive"

class Referral
  def self.worksheet
    service_account_io = OpenStruct.new(read: "{
      \"type\": \"service_account\",
      \"project_id\": \"#{ENV["GOOGLE_DRIVE_PROJECT_ID"]}\",
      \"private_key\": \"#{ENV["GOOGLE_DRIVE_PRIVATE_KEY"]}\",
      \"client_email\": \"#{ENV["GOOGLE_DRIVE_CLIENT_EMAIL"]}\"
    }")

    session = GoogleDrive::Session.from_service_account_key(service_account_io)
    session.spreadsheet_by_key(ENV.fetch("GOOGLE_DRIVE_SPREADSHEET_ID")).worksheets[0]
  end

  def self.all
    worksheet.rows
      .select { |row|
        # only use links from folks who've opted in
        row[3] == "Y"
      }.map { |row|
        # columns are zero-indexed
        Referral.new(
          code: row[2],
          person_name: row[0],
          service_provider: row[1]
        )
      }
  end

  def self.random(service_provider_id: nil)
    referrals = if service_provider_id.nil?
      Referral.all
    else
      Referral.all.select { |referral|
        referral.service_provider_id == service_provider_id
      }
    end

    referrals.sample
  end

  attr_reader :id, :code, :person_name, :service_provider

  def initialize(code:, person_name:, service_provider:)
    @id = Digest::SHA2.hexdigest("#{service_provider} ::: #{code}")
    @code = code
    @person_name = person_name
    @service_provider = service_provider
  end

  def service_provider_id
    @service_provider.parameterize
  end
end
