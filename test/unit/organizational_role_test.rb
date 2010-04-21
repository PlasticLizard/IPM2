require 'test_helper'

class OrganizationalRoleTest < ActiveSupport::TestCase
 context "Saving a nested organizational role" do
    should "align with its parent role's department if not yet set" do
      department = Department.create! :name=>"d1"
      role = OrganizationalRole.create! :name=>"r1", :department=>department
      child = OrganizationalRole.create! :name=>"r2", :parent=>role
      assert_equal department.id, child.department_id
    end
  end
end
