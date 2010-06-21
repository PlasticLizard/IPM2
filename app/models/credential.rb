class Credential < AccountModel

  key :name, String
  key :duty_requirement, Boolean

  key :department_id, ObjectId, :index=>true
  belongs_to :department

  #the number of days from the date a credential is issued until is expires
  #a value of 0 indicates that the credential never expires once issued
  key :days_until_expiration, Integer, :default=>0

  scope :by_department,  lambda { |department_id| where(:department_id => department_id) }

  def self.by_type(type_name)
    type_name = "Credentials::" + type_name unless type_name =~ /^Credentials\:\:.*/
    where(:_type=>type_name)
  end

  def type
    self.class.name.split("::")[-1]
  end

  def issued_to
    Account.current.employees.all 'issued_credentials.credential_id'=>id
  end

  def self.credential_types
    #TODO: should auto-load these at startup from app/models/credentials folder
    %w(Certification CheckRide ClinicalRotation License Training)
  end
end

