require 'spec_helper'

describe Admin::RequirementGroupsController do

  #Delete this example and add some real ones
  it "should use Admin::CredentialGroupController" do
    controller.should be_an_instance_of(Admin::RequirementGroupsController)
  end

  it "should add the provided credential to the list of requirements" do
    cred = Credentials::Certification.create! :name=>"My Cert"
    rs = RequirementSet.create! :name=>"rs1"
    group = rs.requirement_groups[0]
    put "add_requirement", :requirement_set_id=>rs.id.to_s,:id=>group.id.to_s, :required_credential_id=>cred.id.to_s
    rs.reload
    rs.requirement_groups[0].required_credential_ids.should include cred.id.to_s
  end

  it "should remove the provided credential from the list of requirements" do
    cred = Credentials::Certification.create! :name=>"My Cert"
    rs = RequirementSet.create! :name=>"rs1"
    rs.requirement_groups[0].required_credentials << cred
    rs.save!
    delete "remove_requirement", :requirement_set_id=>rs.id.to_s, :id=>rs.requirement_groups[0].id.to_s, :required_credential_id=>cred.id.to_s
    rs.reload
    rs.requirement_groups[0].required_credential_ids.should_not include cred.id.to_s
  end

end
