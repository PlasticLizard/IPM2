require 'spec_helper'

describe ComplianceStatus do
  before(:each) do
  end

  it "calculate days valid from valid_unit" do
    status = ComplianceStatus.new("a","a")
    status.valid_until = Date.today.advance(:days=>15)
    status.days_valid.should == 15
  end

  it "calculate nil days valid when valid_until is nil" do
    status = ComplianceStatus.new("a","a")
    status.days_valid.should be nil
  end

  it "should return a status of 'incomplete' when incomplete flag is set" do
    status = ComplianceStatus.new("a","a")
    status.incomplete!
    status.status.should equal :incomplete
  end

  it "should return a status of 'current' there is no expiration date" do
    status = ComplianceStatus.new("a","a")
    status.status.should equal :current
  end

  it "should return a status of expired when appropriate" do
    status = ComplianceStatus.new("a","a")
    status.valid_until = Date.yesterday
    status.status.should equal :expired
  end

  it "should return a status of 'expiration imminent' when expiring within 7 days" do
    status = ComplianceStatus.new("a","a")
    status.valid_until = Date.tomorrow
    status.status.should equal :expiration_imminent
  end

  it "should return a status of 'expires_soon' when expiring within 30 days" do
    status = ComplianceStatus.new("a","a")
    status.valid_until = Date.today.advance(:days=>25)
    status.status.should equal :expires_soon
  end

  it "should return a status of 'current' when expiring after 30 days" do
    status = ComplianceStatus.new("a","a")
    status.valid_until = Date.today.advance(:days=>31)
    status.status.should equal :current
  end
end