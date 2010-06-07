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
  
  def initialize(*args)
    #Constructor in the form of IssuedCredential.new({attributes:hash})

    return super if args[0].kind_of?(Hash)

    #Constructor in the form of IssuedCredential.new(credential,options)
    options = args.extract_options!
    if args[0] && args[0].kind_of?(Credential)
      self.credential = args[0]
      self.credential_type = self.credential.class.name if self.credential
      self.credential_name = self.credential.name if self.credential
      self.issue_date = options[:issue_date] || Date.today
      self.expiration_date = options[:expiration_date]
    end

  end


  def days_until_expiration
    self.expiration_date.blank? ? nil :
      (self.expiration_date - Date.today)
  end

  def expired?
    days_until_expiration && days_until_expiration < 0
  end
  
end