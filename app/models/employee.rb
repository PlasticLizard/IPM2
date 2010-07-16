class Employee < User
   
  key :organizational_unit_id, ObjectId, :index=>true
  belongs_to :organizational_unit

  key :organizational_unit_ids, Array, :typecast=>'ObjectId'
  many :organizational_units, :in=>:organizational_unit_ids, :class_name=>'OrganizationalUnit'

  key :organizational_role_id, ObjectId, :index=>true
  belongs_to :organizational_role

  key :department_id, ObjectId, :index=>true
  belongs_to :department

  key :requirement_compliance, ComplianceStatusGroup

  ensure_index [[:department_id,1], [:organizational_role_id,1], [:organizational_unit_id,1]]


  many :issued_credentials do
    def latest(credential)
      cred_id = credential.kind_of?(Credential) ? credential.id.to_s : credential.to_s
      self.select{|issued|issued.credential_id.to_s == cred_id}.sort do |a,b|
        a.issue_date <=> b.issue_date
      end.last
    end
    def status(credential)
      Services::EmployeeRequirements::Service.current.check_employee_compliance_for_credential(credential, proxy_owner)
    end
  end

  def issue_credential(credential, options={})
    Services::EmployeeRequirements::Service.current.issue_credential(credential,self,options)
  end

  def remove_credential(issued_credential_id)
    issued_credentials.reject!{|c|c.id.to_s == issued_credential_id.to_s}
    save!
  end



end