require 'spec_helper'

describe Account do
  before(:each) do
    @valid_attributes = {
            :name=>"My Account"
    }
  end

  it "should create a new instance given valid attributes" do
    Account.create!(@valid_attributes)
  end

  it "should ensure at least one company exists when saved" do
    a = Account.create!(@valid_attributes)
    a.companies.size.should equal 1
    a.companies[0].name.should equal a.name
  end

  it "should organize credentials by department and type" do
    d1 =Department.create :name=>"d1"
    d2 = Department.create :name=>"d2"
    d3 = Department.create :name=>"d3"
    Credentials::Certification.create :name=>"c1", :department=>d2
    Credentials::Training.create :name=>"t1", :department=>d2
    Credentials::Certification.create :name=>"c2", :department=>d3

    hierarchy = Account.current.credentials.by_department_and_type
    hierarchy.length.should equal 3
    hierarchy.keys[0].should == d1
    hierarchy.keys[1].should == d2
    hierarchy.keys[2].should == d3
    hierarchy[d1].should be nil
    hierarchy[d2].length.should be 2
    hierarchy[d2]["Certification"][0].name.should == "c1"
    hierarchy[d2]["Training"][0].name.should == "t1"
    hierarchy[d3]["Certification"][0].name.should == "c2"
  end

  it "should organize requirement sets by department" do
    d1 =Department.create :name=>"d1"
    d2 = Department.create :name=>"d2"
    d3 = Department.create :name=>"d3"
    rs1 = RequirementSet.create! :name=>"rs1", :department=>d1
    rs2 = RequirementSet.create! :name=>"rs2", :department=>d1
    rs3 = RequirementSet.create! :name=>"rs3", :department=>d3

    hierarchy = Account.current.requirement_sets.by_department
    hierarchy.length.should equal 3
    hierarchy.keys[0].should == d1
    hierarchy.keys[1].should == d2
    hierarchy.keys[2].should == d3
    hierarchy[d1].length.should be 2
    hierarchy[d2].should == []
    hierarchy[d3].length.should be 1
  end


end
