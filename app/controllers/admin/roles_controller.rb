class Admin::RolesController < AccountResourceController
  belongs_to :department
  respond_to :json

  def collection
    @roles ||= parent.roles.ordered_by_ancestry
  end

  def update
    return super unless parent_id = params["role"].delete("parent_id")
    resource.update_attributes(get_parented_attributes(parent_id,params))
    render :nothing=>true
  end

  def create
    return super unless parent_id = params["role"].delete("parent_id")
    new_child = OrganizationalRole.create!(get_parented_attributes(parent_id,params))
    render :json=>new_child.to_json
  end

  protected
  def get_parented_attributes(parent_id,params)
    parent_id = parent_id.to_i
    parent_role = OrganizationalRole.find(parent_id)
    attributes = params["role"]
    attributes[:parent] = parent_role
    department_id = attributes.delete("department_id")
    attributes[:department_id] = department_id.to_i if department_id
    attributes
  end
end
