require 'spec_helper'

describe Admin::CredentialsController do

  #Delete this example and add some real ones
  it "should use Admin::CredentialController" do
    controller.should be_an_instance_of(Admin::CredentialsController)
  end

  it "should create credentials of the appropriate type" do
    post "create", :type=>"License", :credential=>{:name=>"Hi-C"}
    cred = Credential.find_by_name("Hi-C")
    cred.class.should equal Credentials::License
  end

  it "should set the department when provided" do
    d = Department.create! :name=>"department"
    get "list", :department_id=>d.id.to_s
    assigns["department"].should == d
  end

  it "should present all credentials for a given department, grouped by type" do
    d = Department.create! :name=>"d1"
    d2 = Department.create! :name=>"d2"

    c1 = Credentials::Certification.create! :name=>"c1", :department=>d
    t1 = Credentials::Training.create! :name=>"t1", :department=>d
    t2 = Credentials::Training.create! :name=>"t2", :department=>d2

    get "list", :department_id=>d.id.to_s
    creds = assigns["credentials"]
    creds.length.should equal 2
    creds.keys[0].should == "Certification"
    creds.keys[1].should == "Training"
    creds["Certification"][0].should == c1
    creds["Training"][0].should == t1
  end

  it "should present credentials filtered by type" do
    d = Department.create! :name=>"d"
    c1 = Credentials::Certification.create! :name=>"c1", :department=>d
    t1 = Credentials::Training.create! :name=>"t1", :department=>d

    get "list", :department_id=>d.id.to_s, :credential_type=>"Training"

    creds = assigns["credentials"]
    creds.length.should equal 1
    creds["Training"][0].should == t1
  end

end
