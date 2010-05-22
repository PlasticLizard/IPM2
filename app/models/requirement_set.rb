class RequirementSet < AccountModel

  key :name, String
  key :description, String

  key :organizational_role_ids, Array
  many :organizational_roles, :in=>:organizational_role_ids

  key :organizational_unit_ids, Array
  many :organizational_units, :in=>:organizational_unit_ids
  
  key :department_id, ObjectId
  belongs_to :department

  key :type, String

  many :requirement_groups


end