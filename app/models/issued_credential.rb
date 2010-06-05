class IssuedCredential
  include MongoMapper::EmbeddedDocument

  key :credential_id, ObjectId
  belongs_to :credential

  key :credential_type, String

  key :issue_date, Date, :default=>lambda {Date.today}
  key :expiration_date, Date

  def days_until_expiration
    self.expiration_date.blank? ? nil :
      (self.expiration_date - Date.today)
  end

  def expired?
    days_until_expiration && days_until_expiration < 0
  end

end