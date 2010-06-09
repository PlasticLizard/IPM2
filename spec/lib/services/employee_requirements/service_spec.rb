require 'spec_helper'

describe Services::EmployeeRequirements::ComplianceStatus do
  before(:each) do
    @service = Services::EmployeeRequirements::Service.new
  end

  it ".issue_credential should add an appropriately configured IssuedCredential to the provided employee for the provided credential" do
    emp = Employee.create! :name=>"Here I Am"
    cred1 = Credentials::Certification.create! :name=>"ta da"
    cred2 = Credentials::Training.create! :name=>"Sexiness Training"

    @service.issue_credential(cred1,emp,:issue_date=>Date.yesterday,:expiration_date=>Date.tomorrow)
    @service.issue_credential(cred2, emp)

    emp = emp.reload

    emp.issued_credentials.count.should equal 2
    emp.issued_credentials.select{|c|c.credential.name=="ta da"}[0].issue_date.should == Date.yesterday
    emp.issued_credentials.select{|c|c.credential.name=="ta da"}[0].expiration_date.should == Date.tomorrow
    emp.issued_credentials.select{|c|c.credential.name=="Sexiness Training"}[0].issue_date.should == Date.today
    emp.issued_credentials.select{|c|c.credential.name=="Sexiness Training"}[0].expiration_date.should be nil
  end

  it ".check_employee_compliance should bubble 'incomplete' if any credential is missing and the rule is :all" do
    emp = Employee.create! :name=>"Here I Am"
    cred1 = Credentials::Certification.create! :name=>"ta da"
    cred2 = Credentials::Training.create! :name=>"Sexiness Training"

    emp.issue_credential(cred1)

    rs = RequirementSet.create! :name=>"ha!"
    rs.requirement_groups[0].required_credentials << cred1
    rs.requirement_groups[0].required_credentials << cred2

    status = @service.check_employee_compliance(rs,emp)

    status.status.should == :incomplete
    status.name.should == emp.full_name_formal
    status.context.should be emp
    status.children[0].status.should == :incomplete
    status.children[0].children.length.should equal 2
    status.children[0].children[0].status.should == :current
    status.children[0].children[1].status.should == :incomplete

  end

  it ".check_employee_compliance should show current if any components are current and the rule is :any" do
         emp = Employee.create! :name=>"Here I Am"
    cred1 = Credentials::Certification.create! :name=>"ta da"
    cred2 = Credentials::Training.create! :name=>"Sexiness Training"

    emp.issue_credential(cred1)

    rs = RequirementSet.create! :name=>"ha!"
    rs.requirement_groups[0].operator = :any
    rs.save!
    rs.requirement_groups[0].required_credentials << cred1
    rs.requirement_groups[0].required_credentials << cred2

    status = @service.check_employee_compliance(rs,emp)

    status.status.should == :current
    status.name.should == emp.full_name_formal
    status.context.should be emp
    status.children[0].status.should == :current
    status.children[0].children.length.should equal 2
    status.children[0].children.find{|s|s.name=="ta da"}.status.should == :current
    status.children[0].children.find{|s|s.name=="Sexiness Training"}.status.should == :incomplete
  end
end