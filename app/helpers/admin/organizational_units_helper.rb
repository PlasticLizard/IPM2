module Admin::OrganizationalUnitsHelper
  def organizational_unit_type
    resource.class.name.underscore
  end  
end
