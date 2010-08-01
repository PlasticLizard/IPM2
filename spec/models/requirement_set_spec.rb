require 'spec_helper'

describe RequirementSet do
  before(:each) do
    @valid_attributes = {
      :name=>"My Requirement Set"
    }
  end

  it "should create a new instance given valid attributes" do
    RequirementSet.create!(@valid_attributes)
  end

  it "should create a credential group if none already exists" do
    rs = RequirementSet.create! @valid_attributes
    rs.requirement_groups.count.should equal 1
  end

  it "should not create a credential group if one exists" do
    rs = RequirementSet.new :name=>"hi there"
    rs.requirement_groups << CredentialGroup.new
    rs.save!
    rs.requirement_groups.count.should equal 1
  end

  it "should retrieve all employees when no criteria are specified" do
    Employee.create! :full_name=>"Chairman Mao"
    Employee.create! :full_name=>"Bozo Clown"
    rs = RequirementSet.new :name=>"everybody in the bloody system"
    employees = rs.employees
    employees.count.should equal 2
    employees[1].last_name.should == "Mao"
    employees[0].last_name.should == "Clown"
  end

  it "should retrieve all employees in a given department when only department is specified" do
    d = Department.create! :name=>"My Department"
    d2 = Department.create! :name=>"Your Department"
    Employee.create! :full_name=>"Chairman Mao", :department=>d
    Employee.create! :full_name=>"Bozo Clown", :department=>d
    Employee.create! :full_name=>"The Shadow", :department=>d2
    rs = RequirementSet.new :name=>"everybody in my department", :department=>d
    employees = rs.employees
    employees.count.should equal 2
    employees[1].last_name.should == "Mao"
    employees[0].last_name.should == "Clown"
  end

  it "should retrieve all employees assigned to a particular organizational unit" do
    ou = OrganizationalUnit.create! :name=>"My OU"
    ou2 = OrganizationalUnit.create! :name=>"Your OU"
    Employee.create! :full_name=>"Mr One", :organizational_unit=>ou, :organizational_unit_ids=>[ou.id]
    Employee.create! :full_name=>"Mr Two", :organizational_unit=>ou2, :organizational_unit_ids=>[ou2.id]
    Employee.create! :full_name=>"Mr Three", :organizational_unit=>ou, :organizational_unit_ids=>[ou.id]
    rs = RequirementSet.new :name=>"this and that", :organizational_unit_ids=>[ou.id]
    employees = rs.employees
    employees.count.should equal 2
    employees[0].last_name.should == "One"
    employees[1].last_name.should == "Three"
  end

  it "should retrieve all employees with a particular role" do
    r = OrganizationalRole.create! :name=>"My Role"
    r2 = OrganizationalRole.create! :name=>"Your Role"
    Employee.create! :full_name=>"Mr One", :organizational_role=>r
    Employee.create! :full_name=>"Mr Two", :organizational_role=>r
    Employee.create! :full_name=>"Mr Three", :organizational_role=>r2
    rs = RequirementSet.new :name=>"this and that", :organizational_role_ids=>[r.id]
    employees = rs.employees
    employees.count.should equal 2
    employees[0].last_name.should == "One"
    employees[1].last_name.should == "Two"
  end

  it "should retrieve employees with a role or organizational unit that matches the requirement set" do
    r = OrganizationalRole.create! :name=>"R1"
    r2 = OrganizationalRole.create! :name=>"R2"
    ou = OrganizationalUnit.create! :name=>"OU1"
    ou2 = OrganizationalUnit.create! :name=>"OU2"
    Employee.create! :full_name=>"Mr One", :organizational_role=>r, :organizational_unit=>ou, :organizational_unit_ids=>[ou.id]
    Employee.create! :full_name=>"Mr Two", :organizational_role=>r2, :organizational_unit=>ou, :organizational_unit_ids=>[ou.id]
    Employee.create! :full_name=>"Mr Three", :organizational_role=>r,:organizational_unit=>ou2, :organizational_unit_ids=>[ou2.id]
    Employee.create! :full_name=>"Mr Four", :organizational_role=>r2, :organizational_unit=>ou2, :organizational_unit_ids=>[ou2.id]
    rs = RequirementSet.new :name=>"this and that", :organizational_role_ids=>[r.id], :organizational_unit_ids=>[ou.id,ou2.id]
    employees = rs.employees
    employees.count.should equal 2
    employees[0].last_name.should == "One"
    employees[1].last_name.should == "Three"
  end


 end
