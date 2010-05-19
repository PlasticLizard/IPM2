module Admin::RequirementSetsHelper
  def required_roles_list
    resource.organizational_roles.blank? ?
             "all departmental employees" : resource.organizational_roles.map{|role|role.name}.join(",")
  end

  def required_role_ids
    resource.organizational_roles.map{|role|role.id.to_s} || []
  end

  def required_ou_list
    resource.organizational_units.blank? ?
            "any location" : resource.organizational_units.map{|ou|ou.name}.join(",")
  end

  def required_ou_ids
    resource.organizational_units.map{|ou|ou.id.to_s} || []
  end
end
