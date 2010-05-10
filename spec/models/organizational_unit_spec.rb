require 'spec_helper'

describe OrganizationalUnit do
  before(:each) do
    @valid_attributes = {

            }
  end

  it "should create a new instance given valid attributes" do
    OrganizationalUnit.create!(@valid_attributes)
  end

  it "should act like a tree" do
    c1 = OrganizationalUnit.create! :name=>"Company 1"
    r1 = OrganizationalUnit.create! :name=>"Region 1", :parent=>c1
    b1 = OrganizationalUnit.create! :name=>"Base 1", :parent=>r1
    b2 = OrganizationalUnit.create! :name=>"Base 2", :parent=>r1
    r2 = OrganizationalUnit.create! :name=>"Region 2", :parent=>c1
    b3 = OrganizationalUnit.create! :name=>"Base 3", :parent=>r2

    c1 = OrganizationalUnit.find_by_name("Company 1")

    c1.descendants.count.should equal 5
    b1.ancestors.count.should equal 2
    b2.siblings.count.should equal 1
    b2.siblings.should include b1
    b3.siblings.count.should equal 0
  end

  it "should create children appropriate to its type" do
    c = Company.create! :name=>"c1"
    r = c.create_child!(:name=>"r1")
    r.class.should equal Region
    r.name.should == "r1"
  end

  it "should present roles appropriate to its type" do
    r1 = OrganizationalRole.create! :name=>"r1", :organizational_unit_type=>'company'
    r2 = OrganizationalRole.create! :name=>"r2", :organizational_unit_type=>'region'
    r3 = OrganizationalRole.create! :name=>"r3", :organizational_unit_type=>'company'
    c = Company.create! :name=>"c1"
    c.roles.count.should equal 2
    c.roles.should include r1
    c.roles.should include r3
    c.roles.should_not include r2
  end

end
