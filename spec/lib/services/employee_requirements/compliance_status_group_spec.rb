require 'spec_helper'

describe Services::EmployeeRequirements::ComplianceStatusGroup do
  before(:each) do
  end

  it "should mark itself incomplete when a child is incomplete and the operator is not 'any'" do
    group = Services::EmployeeRequirements::ComplianceStatusGroup.new("a","a")
    group << create_status(:incomplete=>true)
    group.should be_incomplete
  end

  it "should not mark itself incomplete when a child is incomplete and the operator is 'any'" do
    group = Services::EmployeeRequirements::ComplianceStatusGroup.new("a","a",:operator=>:any)
    group << create_status(:incomplete=>true)
    group << create_status
    group.should_not be_incomplete
  end

  it "should mark itself incomplete when all children are incomplete and any operator is used" do
    group = Services::EmployeeRequirements::ComplianceStatusGroup.new("a","a",:require=>:any)
    group << create_status(:incomplete=>true)
    group << create_status(:incomplete=>true)
    group.should be_incomplete
  end

  it ".valid_until should return the first expiration date of the groups children when operator is 'all'" do
    group = Services::EmployeeRequirements::ComplianceStatusGroup.new("a","a")
    group << create_status(:valid_until=>Date.today)
    group << create_status(:valid_until=>Date.tomorrow)
    group << create_status(:valid_until=>Date.yesterday)
    group.valid_until.should == Date.yesterday
  end

  it ".valid_until should return the last expiration date of the groups children when the operator is 'any'" do
    group = Services::EmployeeRequirements::ComplianceStatusGroup.new("a","a",:require=>:any)
    group << create_status(:valid_until=>Date.today)
    group << create_status(:valid_until=>Date.tomorrow)
    group << create_status(:valid_until=>Date.yesterday)
    group.valid_until.should == Date.tomorrow  
  end

end

def create_status(options={})
  status = Services::EmployeeRequirements::ComplianceStatus.new("a","a")
  status.valid_until = options[:valid_until]
  status.incomplete! if options[:incomplete]
  status
end