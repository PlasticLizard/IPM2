class Services::EmployeeRequirements::Service
  @@current
  def self.current
    @@current ||= Service.new
  end

  def check_compliance(requirement_set)
    employees = requirement_set.employees
    status = ComplianceStatus.new(requirement_set.name)
    employees.each do |employee|
      status.children << check_employee_compliance(requirement_set,employee)
    end
    status
  end
  
  def check_employee_compliance(requirement_set,employee)
    status = ComplianceStatus.new(employee.full_name_formal)
    requirement_set.requirement_groups.each do |group|
      group_status = ComplianceStatus.new(group.name,:require=>group.operator || :all)
      group.required_credentials.each do |credential|
        credential_status = ComplianceStatus.new(credential.name)
        emp_credential = employee.credentials.latest(credential)
        unless emp_credental.blank?
          credential_status.valid_until = emp_credential.expiration_date
        else
          credential_status.incomplete!
        end
        group_status.children << credential_status
      end
      status.children << group_status
    end
    status
  end
end