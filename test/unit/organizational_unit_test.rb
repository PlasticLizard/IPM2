require 'test_helper'

class OrganizationalUnitTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  #fixtures :organizational_units
  def setup
    Account.set_current_account(Account.first || Account.create!(:name=>"Lieutenant Dan"))
  end
  
  context "OrganizationalUnits" do
    should "really act like trees" do
      c1 = OrganizationalUnit.create! :name=>"Company 1"
      r1 = c1.children.create! :name=>"Region 1"
      b1 = r1.children.create! :name=>"Base 1"
      b2 = r1.children.create! :name=>"Base 2"
      r2 = c1.children.create! :name=>"Region 2"
      b3 = r2.children.create! :name=>"Base 3"

      c1 = OrganizationalUnit.find_by_name("Company 1")

      assert_equal 5, c1.descendants.count
      assert_equal 2, b1.ancestors.count
      assert_equal 2, b2.siblings.count
      assert b2.siblings.include?(b1)
      assert b3.is_only_child?
    end   
  end
end
