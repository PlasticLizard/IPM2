require 'spec_helper'

describe Employee do
  before(:each) do
    @valid_attributes = {

            }
  end

  it "should create a new instance given valid attributes" do
    Employee.create!(@valid_attributes)
  end

  it "should provide the most recently issued issued credential for a given credential" do
    c1 = Credentials::Certification.create! :name=>"hi"
    c2 = Credentials::Certification.create! :name=>"there"

    emp = Employee.new :issued_credentials => [
              IssuedCredential.new(:credential=>c1, :issue_date=>Date.today),
              IssuedCredential.new(:credential=>c2, :issue_date=>Date.tomorrow),
              IssuedCredential.new(:credential=>c1, :issue_date=>Date.yesterday)
            ]
    issued = emp.issued_credentials.latest(c1)
    issued.issue_date.should == Date.today
  end

  it "should return null when queried for an issued credential that an employee does not have" do
    c1 = Credentials::Certification.create! :name=>"hi"
    c2 = Credentials::Certification.create! :name=>"there"

    emp = Employee.new :issued_credentials => [
              IssuedCredential.new(:credential=>c2, :issue_date=>Date.tomorrow)
            ]
    emp.issued_credentials.latest(c1).should be nil
  end

  it "should return the correct status for a provided credential" do
    c1 = Credentials::Certification.create! :name=>"hi"

    emp = Employee.new :issued_credentials => [
              IssuedCredential.new(:credential=>c1, :issue_date=>Date.today, :expiration_date=>Date.tomorrow),
            ]
    status = emp.issued_credentials.status(c1)
    status.status.should == :expiration_imminent
    status.valid_until.should == Date.tomorrow
  end


 
end