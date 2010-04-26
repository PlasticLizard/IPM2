require 'spec_helper'

describe Department do
  before(:each) do
    @valid_attributes = {
      :name=>"Department 1" 
    }
  end

  it "should create a new instance given valid attributes" do
    Department.create!(@valid_attributes)
  end  

end
