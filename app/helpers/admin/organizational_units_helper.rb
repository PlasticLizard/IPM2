module Admin::OrganizationalUnitsHelper
  def organizational_unit_type
    resource.class.name.underscore
  end

  def organizational_unit_header
    render :partial=>"admin/shared/organizational_unit_header", :locals=>{:ou=>resource, :company=>@company}
  end
end
