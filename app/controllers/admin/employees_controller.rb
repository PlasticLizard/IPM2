class Admin::EmployeesController < InheritedResources::Base
  include AccountResourceController

  def per_page
    25
  end

  def show
    @issued_credentials = resource.issued_credentials
    super
  end

  def create
    create! do |format|
      format.html { redirect_to collection_url }
    end
  end

  def update
    update! do |format|
      format.html {redirect_to collection_url}
      format.json {head :ok}
    end
  end

  def index
    @show_title = true
    @departments = current_account.roles.by_department
    index! do |format|
      format.html {
        return render :partial=>"employee_list" if request.xhr?
        render :index
      }
    end
  end

  def collection
    query = current_account.employees
    filter = {}
    filter[:full_name]=/#{params[:q]}/i unless params[:q].blank?
    filter[:department_id] = params[:departments] unless params[:departments].blank?
    filter[:organizational_role_id] = params[:roles] unless params[:roles].blank?
    filter[:organizational_unit_id] = params[:organizational_units] unless params[:organizational_units].blank?
    query = query.all(filter) unless filter.blank?

    @employees ||= query.paginate :page=>params[:page], :per_page=>(params[:per_page] || per_page)
  end


end
