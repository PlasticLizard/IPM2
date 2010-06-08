class IssuedCredential
  include MongoMapper::EmbeddedDocument

  key :credential_id, ObjectId
  belongs_to :credential

  key :credential_type, String
  key :credential_name, String

  key :issue_date, Date, :default=>lambda {Date.today}
  key :expiration_date, Date

  def credential_type_name
    self.credential_type.split("::")[-1].titleize
  end

  def days_until_expiration
    self.expiration_date.blank? ? nil :
      (self.expiration_date - Date.today)
  end

  def expired?
    days_until_expiration && days_until_expiration < 0
  end
  
end