class Admin::EmployeesController < InheritedResources::Base
  include AccountResourceController

  def per_page
    20
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
    super
  end

  def collection
    @employees ||= current_account.employees.paginate :page=>params[:page], :per_page=>(params[:per_page] || per_page)
  end


end
