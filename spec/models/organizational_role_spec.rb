require 'spec_helper'

describe OrganizationalRole do
  before(:each) do
    @valid_attributes = {
            :name=>"My Role"
    }
  end

  it "should create a new instance given valid attributes" do
    OrganizationalRole.create!(@valid_attributes)
  end

  it "should be invalid without a name" do
    role = OrganizationalRole.new @valid_attributes.except(:name)
    role.should_not be_valid
    role.errors.on(:name).should_not be_empty
    role.name = "Ta da"
    role.should be_valid
  end

  it "should align with its parent role's department if not yet set" do
    department = Department.create! :name=>"d1"
    role = OrganizationalRole.create! :name=>"r1", :department=>department
    child = OrganizationalRole.create! :name=>"r2", :parent=>role
    child.department_id.should equal  department.id
  end


end
