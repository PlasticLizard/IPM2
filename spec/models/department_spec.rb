require 'spec_helper'

describe Department do
  before(:each) do
    @valid_attributes = {
      :name=>"Department 1" 
    }
  end

  it "should create a new instance given valid attributes" do
    Department.create!(@valid_attributes)
  end

  it "should create a default department head upon save if no roles exist" do
    d = Department.create!(@valid_attributes)
    d = Department.find(d.id)
    d.roles.count.should equal 1
    d.roles[0].name.should == "Department 1 Director"
    d.department_head.should == d.roles[0]
  end

  it "should not create any new roles if roles are already present" do
    d = Department.new(@valid_attributes)
    d.roles.build :name=>"Lord of the Lieu"
    d.save
    d = Department.find(d.id)
    d.roles.count.should equal 1
    d.roles[0].name.should == "Lord of the Lieu"
  end

end
