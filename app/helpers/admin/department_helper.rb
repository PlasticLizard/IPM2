module Admin::DepartmentHelper
  def department_head_name
    return @department.department_head.name if @department.department_head
    "No department head configured" 
  end


#  def department_head_options
#    return "No roles have been created for this department" unless @department.roles
#    "[#{@department.roles.roots.map{|r|"['#{r.name}','#{r.id}']"}.join(",")}]"
#  end
end
