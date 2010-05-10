class Admin::OrganizationalUnitsController < AccountResourceController
  belongs_to :company
  def resource
    get_resource_ivar || set_resource_ivar(OrganizationalUnit.find(params[:id]))
  end

  def collection
    get_collection_ivar || set_collection_ivar(parent.descendants)
  end

  def show
    show! do |format|
      format.all { render :partial=>"show"}
    end
  end

  def create
    create! do |format|
      format.json {render :nothing=>true}
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
end
