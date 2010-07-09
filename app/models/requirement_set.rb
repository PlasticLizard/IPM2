class RequirementSet < AccountModel

  key :name, String, :required=>true
  key :description, String

  key :organizational_role_ids, Array
  many :organizational_roles, :in=>:organizational_role_ids

  key :organizational_unit_ids, Array
  many :organizational_units, :in=>:organizational_unit_ids
  
  key :department_id, ObjectId
  belongs_to :department

  many :requirement_groups, :class_name=>'CredentialGroup'

  def employees
    filter = {}
    filter[:department_id] = department_id unless department_id.blank?
    filter[:organizational_unit_id] = organizational_unit_ids unless organizational_unit_ids.blank?
    filter[:organizational_role_id] = organizational_role_ids unless organizational_role_ids.blank?
    Account.current.employees.all filter
  end
  
  after_save :ensure_requirement_group
  def ensure_requirement_group
    unless requirement_groups.size > 0
      requirement_groups.build
      save!
    end
  end

end