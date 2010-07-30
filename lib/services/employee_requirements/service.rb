class Services::EmployeeRequirements::Service

  def self.current
    @@current ||= Services::EmployeeRequirements::Service.new
  end

  def issue_credential(credential,employee,options={})
    ic = employee.issued_credentials.build
    ic.credential = credential
    ic.credential_type = credential.class.name
    ic.credential_name = credential.name
    ic.issue_date = options[:issue_date] || Date.today
    ic.expiration_date = options[:expiration_date]
    employee.save!
    ic
  end

#  def update_requirement_set_compliance(requirement_set,employees=nil)
#    employees ||= requirement_set.employees
#    requirement_set.compliance_status ||= ComplianceStatusGroup.new(requirement_set.name, requirement_set)
#    status = requirement_set.compliance_status
#    employees.each do |employee|
#      status << update_employee_compliance(requirement_set,employee)
#    end
#    requirement_set.save!
#    status
#  end

  def clear_employee_requirement_compliance
    Employee.set({},:requirement_compliance=>nil, :_type=>"Employee")
  end
  
  def update_employee_requirement_compliance
    clear_employee_requirement_compliance
    RequirementSet.find_each do |rs|
      rs.employees.each do |emp|
        update_employee_compliance_for_requirement_set(rs,emp)
      end
    end
    EmployeeComplianceStatusCubicle.process
  end

  def update_employee_compliance_for_requirement_set(requirement_set,employee)
    employee.requirement_compliance ||= ComplianceStatusGroup.new(employee.full_name_formal, employee)
    emp_status = employee.requirement_compliance
    
    status = ComplianceStatusGroup.new(requirement_set.name,requirement_set)

    requirement_set.requirement_groups.each do |group|

      group_status = ComplianceStatusGroup.new(group.name,group,:require=>group.operator.to_sym || :all)

      group.required_credentials.each do |credential|
        group_status << check_employee_compliance_for_credential(credential,employee)
      end
      status << group_status
    end

    emp_status << status

    employee.save!
    emp_status
  end

  def check_employee_compliance_for_credential(credential,employee)
    credential_status = ComplianceStatus.new(credential.name,credential)
    emp_credential = employee.issued_credentials.latest(credential)

    unless emp_credential.blank?
      credential_status.valid_until = emp_credential.expiration_date
    else
      credential_status.incomplete!
    end
    credential_status
  end
end