require 'spec_helper'

describe RequirementSet do
  before(:each) do
    @valid_attributes = {
      :name=>"My Requirement Set"
    }
  end

  it "should create a new instance given valid attributes" do
    RequirementSet.create!(@valid_attributes)
  end

  it "should create a credential group if none already exists" do
    rs = RequirementSet.create! @valid_attributes
    rs.requirement_groups.count.should equal 1
  end

  it "should not create a credential group if one exists" do
    rs = RequirementSet.new :name=>"hi there"
    rs.requirement_groups << CredentialGroup.new
    rs.save!
    rs.requirement_groups.count.should equal 1
  end  


 end
