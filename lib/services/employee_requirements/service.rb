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
    #employee.issued_credentials << ic
    employee.save!
    ic
  end

  def check_requirement_set_compliance(requirement_set)
    employees = requirement_set.employees
    status = ComplianceStatusGroup.new(requirement_set.name,requirement_set)
    employees.each do |employee|
      status << check_employee_compliance(requirement_set,employee)
    end
    status
  end

  def check_employee_compliance(requirement_set,employee)
    status = Services::EmployeeRequirements::ComplianceStatusGroup.new(employee.full_name_formal,employee)

    requirement_set.requirement_groups.each do |group|

      group_status = Services::EmployeeRequirements::ComplianceStatusGroup.new(group.name,group,:require=>group.operator.to_sym || :all)

      group.required_credentials.each do |credential|

        credential_status = Services::EmployeeRequirements::ComplianceStatus.new(credential.name,credential)
        emp_credential = employee.issued_credentials.latest(credential)

        unless emp_credential.blank?
          credential_status.valid_until = emp_credential.expiration_date
        else
          credential_status.incomplete!
        end
        
        group_status << credential_status
      end

      status << group_status
    end

    status
  end
end