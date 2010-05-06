require "spec_helper"

describe "OrganizationalUnitHierarchy.context_to_sym" do

  it "should return a symbol unharmed" do
    OrganizationalUnitHierarchy.context_to_sym(:i_is_symbol).should equal :i_is_symbol
  end

  it "should convert a string to a symbol, after underscoring it" do
    OrganizationalUnitHierarchy.context_to_sym("IsISymbol").should equal :is_i_symbol
  end

  it "should convert a class into a symbol" do
    OrganizationalUnitHierarchy.context_to_sym(Company).should equal :company
  end

  it "should convert a class instance into a symbol" do
    OrganizationalUnitHierarchy.context_to_sym(Station.new :name=>"hi").should equal :station
  end
end

describe "OrganizationalUnitHierarchy.child_of" do
  it "should properly detect the child of an item in the hierarchy" do
    h = OrganizationalUnitHierarchy.new(Company,Region,Station,TransportUnit)
    h.child_of(Company).should equal Region
  end

  it "should return nil when child_of is called on the last item in the hierarchy" do
    h = OrganizationalUnitHierarchy.new(Company,Region,Station)
    h.child_of(Station).should be nil
  end

  it "should raise an exception when child_of is called for an item not in the hierarchy" do
    h = OrganizationalUnitHierarchy.new(Company,Region,Station)
    lambda { h.child_of(OrganizationalRole)}.should raise_error RuntimeError
  end

  it "should properly detect the parent of an item in the hierarchy" do
    h = OrganizationalUnitHierarchy.new(Company,Region,Station,TransportUnit)
    h.parent_of(Station).should equal Region
  end

  it "should return nil when parent_of is called on the first item in the hierarchy" do
    h = OrganizationalUnitHierarchy.new(Company,Region,Station)
    h.parent_of(Company).should be nil
  end

  it "should raise an exception when parent_of is called for an item not in the hierarchy" do
    h = OrganizationalUnitHierarchy.new(Company,Region,Station)
    lambda {h.parent_of(OrganizationalRole)}.should raise_error RuntimeError
  end
end