require 'spec_helper'

describe AccountModel do
  before(:each) do
#    @valid_attributes = {
#
#    }
  end


  it "should not be valid without an current account" do
    Account.clear_current_account()
    ou = OrganizationalUnit.new
    ou.should_not be_valid
  end

  it "should be valid with a current account" do
    Account.set_current_account(Account.create!(:name=>"Lieutenant Dan"))
    ou = OrganizationalUnit.create
    ou.should be_valid
    ou.account.should == Account.current
  end 
end
