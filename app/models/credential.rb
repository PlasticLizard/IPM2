class Credential < AccountModel

  key :name, String
  key :duty_requirement, Boolean
  
  #the number of days from the date a credential is issued until is expires
  #a value of 0 indicates that the credential never expires once issued
  key :days_until_expiration, Integer, :default=>0

end