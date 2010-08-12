class Admin::OrganizationalUnitsController  < InheritedResources::Base
  include AccountResourceController
  belongs_to :company, :optional=>true
  def resource
    get_resource_ivar || set_resource_ivar(OrganizationalUnit.find(params[:id]))
  end

  def index
    @companies = current_account.companies
    @show_title = true
    render 'index', :layout=>'left_sidebar'
  end

#  def collection
#    get_collection_ivar || set_collection_ivar(parent.descendants)
#  end

  def show
    @organizational_unit = resource
    if request.xhr?
      render :partial=>"/admin/organizational_units/show"
    else
      index
    end
  end

  def select
    render :partial=>"select"
  end

  def update
    update! do |format|
      format.json {render :nothing=>true}
    end
  end

  def destroy
    destroy! do |format|
      format.all {render :nothing => true}
    end
  end

  def create
    new_ou_attributes = params["organizational_unit"]
    parent_id = new_ou_attributes.delete("parent_id")
    parent_ou = (params["id"] == parent_id) ? resource : OrganizationalUnit.find(parent_id)

    raise "The parent of the requested organizational unit cannot be found" unless parent_ou
    raise "A child cannot be created for #{self} because it is the last level of the organizational hierarchy" unless parent_ou.child_type

    new_ou = parent_ou.create_child!(new_ou_attributes)

    data = new_ou.attributes
    data["collection_name"] = "#{new_ou.class.name.underscore.pluralize}"
    #data["type"] = "#{new_ou.class.name.underscore}:#{new_ou.class.name.underscore.pluralize}"

    render :json=>data.to_json
  end


end
