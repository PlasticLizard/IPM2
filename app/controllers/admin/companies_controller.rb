class Admin::CompaniesController  < InheritedResources::Base
  include AccountResourceController
  
  def collection
    @companies ||= current_account.companies
  end

  def show
    show! do |format|
      format.all { render :partial=>"show"}
    end
  end

  def update
    update! do |format|
      format.json {render :nothing=>true}
    end
   end

  def destroy
    destroy! do |format|
      format.json {render :nothing => true}
    end
  end  

  def organizational_unit
    new_ou_attributes = params["organizational_unit"]
    parent_id = new_ou_attributes.delete("parent_id")
    parent_ou = (params["id"] == parent_id) ? resource : OrganizationalUnit.find(parent_id)

    raise "The parent of the requested organizational unit cannot be found" unless parent_ou
    raise "A child cannot be created for #{self} because it is the last level of the organizational hierarchy" unless parent_ou.child_type

    new_ou = parent_ou.create_child!(new_ou_attributes)

    data = new_ou.attributes
    data["type"] = "#{new_ou.class.name.underscore}:#{new_ou.class.name.underscore.pluralize}"

    render :json=>data.to_json
  end
end
