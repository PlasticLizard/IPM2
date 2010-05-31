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

end
