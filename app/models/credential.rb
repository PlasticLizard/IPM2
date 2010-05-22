class Credential
  include MongoMapper::Document

  key :name, String
  
  key :authority, String #a state, :federal  or some other accrediting body
  key :authority_type, Symbol, :default=>:company
  def self.credential_authority_types; [:company, :state, :federal, :industry_association, :none, :other]; end

  #the number of days from the date a credential is issued until is expires
  #a value of 0 indicates that the credential never expires once issued
  key :days_until_expiration, Integer, :default=>0

end