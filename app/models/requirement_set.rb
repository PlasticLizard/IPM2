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

  after_save :ensure_requirement_group
  def ensure_requirement_group
    unless requirement_groups.size > 0
      requirement_groups.build
      save!
    end
  end

end