class IssuedCredential
  include MongoMapper::EmbeddedDocument

  key :credential_id, ObjectId
  belongs_to :credential

  key :credential_type, String

  key :issue_date, Date
  key :expiration_date, Date

end