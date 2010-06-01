class Employee < User
  key :organizational_unit_id, ObjectId
  belongs_to :organizational_unit

  key :department_id, ObjectId
  belongs_to :department

  many :credentials, :class_name=>'IssuedCredential'


end