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
    r1 = c1.children.create! :name=>"Region 1"
    b1 = r1.children.create! :name=>"Base 1"
    b2 = r1.children.create! :name=>"Base 2"
    r2 = c1.children.create! :name=>"Region 2"
    b3 = r2.children.create! :name=>"Base 3"

    c1 = OrganizationalUnit.find_by_name("Company 1")

    c1.descendants.count.should equal 5
    b1.ancestors.count.should equal 2
    b2.siblings.count.should equal 2
    b2.siblings.should include b1
    b3.should be_is_only_child
  end

  it "should create children appropriate to its type" do
    c = Company.create! :name=>"c1"
    r = c.create_child!(:name=>"r1")
    r.class.should equal Region
    r.name.should == "r1"
  end

end
