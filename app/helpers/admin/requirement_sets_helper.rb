module Admin::RequirementSetsHelper
  def required_roles_list
    resource.organizational_roles.blank? ?
             "all departmental employees" : resource.organizational_roles.map{|role|role.name}.join(",")
  end
end
