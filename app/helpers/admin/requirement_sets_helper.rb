module Admin::RequirementSetsHelper
  def required_roles_list
    resource.organizational_roles.blank? ?
             "all departmental employees" : resource.organizational_roles.map{|role|role.name}.join(",")
  end

  def required_role_ids
    resource.organizational_roles.map{|role|role.id.to_s} || []
  end
end
