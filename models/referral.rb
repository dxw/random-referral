require "google_drive"

class Referral
  def self.worksheet
    # Replace this with GoogleDrive::Session.from_access_token using a token from
    # an environment variable. We'll need to get an access token for that. We could
    # do OAuth ourselves, or we could find out where GoogleDrive caches the access
    # token between executions and grab it from there. We're struggling to find out
    # where the access token is saved, though.
    session = GoogleDrive::Session.from_config(".data/gsuite-auth-config.json")
    worksheet = session.spreadsheet_by_key(ENV["SPREADSHEET_ID"]).worksheets[0]
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
          code: row[2]
        )
      }
  end

  attr_reader :id, :company, :code

  def initialize(id:, company:, code:)
    @id = id
    @company = company
    @code = code
  end
end
