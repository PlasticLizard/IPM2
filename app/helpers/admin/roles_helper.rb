module Admin::RolesHelper

  def position_type_description
    OrganizationalRole.position_types[@role.position_type.to_sym]
  end

  def position_type_select_options
    OrganizationalRole.position_types.map{|key,value|"#{value}:#{key}"}.join(",")
  end

  def organizational_unit_type_options
    Account.current.organizational_structure.map{|ou|"#{ou.to_s.humanize.downcase}:#{ou}"}.join(",")
  end  

end
