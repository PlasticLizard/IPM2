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

  it "should sort departments based on an ordered list of ids" do
    a = Account.current
    d1 = a.departments.create! :name=>"d1"
    d2 = a.departments.create! :name=>"d2"
    d3 = a.departments.create! :name=>"d3"

    a.departments.reorder([d3.id.to_s,d1.id.to_s,d2.id.to_s])

    d1.reload; d2.reload; d3.reload;

    d1.position.should equal 2
    d2.position.should equal 3
    d3.position.should equal 1

  end

  it "should ensure at least one company exists when saved" do
    a = Account.create!(@valid_attributes)
    a.companies.size.should equal 1
    a.companies[0].name.should equal a.name
  end

  it "should return credentials by type" do
    a = Account.current
    c1 = Credentials::Certification.create! :name=>"Happy"
    Credentials::Training.create!:name=>"Sad"

    a.credentials.by_type("Credentials::Certification").count.should equal 1
    a.credentials.by_type("Credentials::Certification")[0].id.should == c1.id
  end

  it "should return credentials by only the class name" do
    a = Account.current
    c1 = Credentials::Certification.create! :name=>"Happy"
    Credentials::Training.create!:name=>"Sad"

    a.credentials.by_type("Certification").count.should equal 1
    a.credentials.by_type("Certification")[0].id.should == c1.id
  end

  it "should return an empty array if no credentials exist that match" do
    a = Account.current
    Credentials::Training.create!:name=>"Sad"

    a.credentials.by_type("Certification").count.should equal 0
  end
end
