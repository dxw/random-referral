class Referral

attr_reader :id, :company, :code

  def initialize(id:, company:, code:)
    @id = id
    @company = company
    @code = code
  end

end