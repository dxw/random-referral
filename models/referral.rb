require "google_drive"

class Referral
  def self.worksheet
    service_account_io = OpenStruct.new(read: "{
      \"type\": \"service_account\",
      \"project_id\": \"#{ENV.fetch("GOOGLE_DRIVE_PROJECT_ID")}\",
      \"private_key\": \"#{ENV.fetch("GOOGLE_DRIVE_PRIVATE_KEY")}\",
      \"client_email\": \"#{ENV.fetch("GOOGLE_DRIVE_CLIENT_EMAIL")}\"
    }")

    # Replace this with GoogleDrive::Session.from_access_token using a token from
    # an environment variable. We'll need to get an access token for that. We could
    # do OAuth ourselves, or we could find out where GoogleDrive caches the access
    # token between executions and grab it from there. We're struggling to find out
    # where the access token is saved, though.
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
          id: row[1].tr(" ", "_").downcase,
          company: row[1],
          code: row[2],
          name: row[0]
        )
      }
  end

  attr_reader :id, :company, :code, :name

  def initialize(id:, company:, code:, name:)
    @id = id
    @company = company
    @code = code
    @name = name
  end
end
