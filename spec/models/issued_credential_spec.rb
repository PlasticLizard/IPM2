require 'spec_helper'

describe IssuedCredential do
  before(:each) do

  end
  after(:each) do
    Timecop.return
  end

  it "should default the issued date to today" do
    IssuedCredential.new.issue_date.should == Date.today  
  end

  it "should correctly calculate days until expiration" do
    ic = IssuedCredential.new :expiration_date=>Time.parse("2010-01-01")
    Timecop.freeze(Time.parse("2009-12-01"))
    ic.days_until_expiration.should == 31
  end

  it "should return nil if no expiration date" do
    ic = IssuedCredential.new
    ic.days_until_expiration.should be nil
  end

  it "should treat a credential with no expiration date as not-expired" do
    ic = IssuedCredential.new
    ic.should_not be_expired
  end

 it "should correctly detect an expired credential" do
   ic = IssuedCredential.new :expiration_date=>Time.now.advance(:days=>-1)
   ic.should be_expired
 end

  it "should correctly detect an un-expired credential" do
    ic = IssuedCredential.new :expiration_date=>Time.now.advance(:days=>1)
    ic.should_not be_expired
  end

  it "should treat a credential expiring today as not expired" do
    ic = IssuedCredential.new :expiration_date=>Date.today
    ic.should_not be_expired
  end

end