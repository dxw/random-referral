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
          id: Digest::SHA2.hexdigest("#{row[1]} ::: #{row[2]}"),
          code: row[2]
        )
      }
  end

  def self.random
    Referral.all.sample
  end

  attr_reader :id, :code

  def initialize(id:, code:)
    @id = id
    @code = code
  end
end
