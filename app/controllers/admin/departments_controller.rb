class Admin::DepartmentsController  < InheritedResources::Base
  include AccountResourceController
  respond_to :json

  def show
    show! do |format|
      format.all { render :partial=>"show"}
    end
  end

  def sort
    current_account.departments.reorder(params[:department])
    render :nothing=>true
  end

  def create
    create! do |format|
      format.json { render :json=>resource.to_json }
    end
  end

  def destroy
    destroy! do |format|
      format.json {render :nothing => true}
    end
  end

  def update
    update! do |format|
      format.json {render :nothing=>true}
    end
  end

  def index
    @departments = current_account.roles.by_department
    @show_title = true
    render :layout=>'left_sidebar'
  end

end
