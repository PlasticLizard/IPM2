require 'spec_helper'

describe Account do
  before(:each) do
    @valid_attributes = {
      :name=>"My Account"
    }
  end

  it "should create a new instance given valid attributes" do
    Account.create!(@valid_attributes)
  end

  it "should sort departments based on an ordered list of ids" do
    a = Account.current
    d1 = a.departments.create! :name=>"d1"
    d2 = a.departments.create! :name=>"d2"
    d3 = a.departments.create! :name=>"d3"

    a.departments.reorder([d3.id.to_s,d1.id.to_s,d2.id.to_s])

    d1.reload; d2.reload; d3.reload;

    d1.position.should equal 2
    d2.position.should equal 3
    d3.position.should equal 1

  end

  it "should ensure at least one company exists when saved" do
    a = Account.create!(@valid_attributes)
    a.companies.size.should equal 1
    a.companies[0].name.should equal a.name
  end
end
