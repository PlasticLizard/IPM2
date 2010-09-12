require 'spec_helper'

describe Admin::IssuedCredentialsController do

  before(:each) do
    sign_in ensure_user
  end

  #Delete this example and add some real ones
  it "should use Admin::IssuedCredentialsController" do
    controller.should be_an_instance_of(Admin::IssuedCredentialsController)
  end

  it "should add the specified credential to the issued_credential list of the current employee" do
    emp = Employee.create! :name=>"Sam Iam", :email=>"iam@sam.com", :password=>"iamsam.com", :password_confirmation=>"iamsam.com"
    cred = Credentials::Certification.create! :name=>"Iam Sam"

    put "issue", :employee_id=>emp.id.to_s,:credential_id=>cred.id.to_s,:issue_date=>"01/01/2001",:expiration_date=>"01/02/2001"

    emp = emp.reload
    emp.issued_credentials.count.should equal 1
    emp.issued_credentials[0].credential_type.should == "Credentials::Certification"
    emp.issued_credentials[0].credential_id.to_s.should == cred.id.to_s
    emp.issued_credentials[0].credential_name.should == "Iam Sam"
    emp.issued_credentials[0].issue_date.should == Time.parse("01/01/2001").to_date
    emp.issued_credentials[0].expiration_date.should == Time.parse("01/02/2001").to_date
    emp.issued_credentials[0].id.should_not be nil
  end

  it "should remove the specified credential" do
    emp = Employee.create! :name=>"Sam Iam", :email=>"sam@iam.com", :password=>"iamsam.com", :password_confirmation=>"iamsam.com"
    cred = Credentials::Certification.create! :name=>"Iam Sam"
    emp.issue_credential(cred)

    delete "revoke",:employee_id=>emp.id.to_s,:issued_credential_id=>emp.issued_credentials[0].id.to_s

    emp = emp.reload
    emp.issued_credentials.count.should equal 0

  end

end
