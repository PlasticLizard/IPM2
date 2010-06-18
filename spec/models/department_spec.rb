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
    d = Department.create!(@valid_attributes)
    d.roles[0].name = "Lord of the Lieu"
    d.save!
    d = Department.find(d.id)
    d.roles.count.should equal 1
    d.roles[0].name.should == "Lord of the Lieu"
  end

   it "should return credentials by type" do
    d = Department.create! :name=>"d1"
    c1 = Credentials::Certification.create! :name=>"Happy", :department=>d
    Credentials::Training.create!:name=>"Sad"

    d.credentials.by_type("Credentials::Certification").count.should equal 1
    d.credentials.by_type("Credentials::Certification")[0].id.should == c1.id
  end

  it "should return credentials by only the class name" do
    d = Department.create! :name=>"d1"
    c1 = Credentials::Certification.create! :name=>"Happy", :department=>d
    Credentials::Training.create!:name=>"Sad"

    d.credentials.by_type("Certification").count.should equal 1
    d.credentials.by_type("Certification")[0].id.should == c1.id
  end

  it "should return an empty array if no credentials exist that match" do
    d = Department.create! :name=>"d1"
    Credentials::Training.create!:name=>"Sad", :department=>d

    d.credentials.by_type("Certification").count.should equal 0
  end

  it "should group credentials by type if no argument is provided to by_type" do
    d = Department.create! :name=>"d1"

    c1 = Credentials::Certification.create! :name=>"Cert1", :department=>d
    c2 = Credentials::Certification.create! :name=>"Cert2", :department=>d
    t1 = Credentials::Training.create! :name=>"Training1", :department=>d

    grouped = d.credentials.by_type
    grouped.length.should be 2
    grouped["Certification"].length.should be 2
    grouped["Training"].length.should be 1
  end

end
