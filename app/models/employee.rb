class Employee < User
   
  key :organizational_unit_id, ObjectId
  belongs_to :organizational_unit

  key :organizational_role_id, ObjectId
  belongs_to :organizational_role

  key :department_id, ObjectId
  belongs_to :department

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