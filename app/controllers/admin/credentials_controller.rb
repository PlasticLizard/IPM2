class Admin::CredentialsController  < InheritedResources::Base
  include AccountResourceController

  belongs_to :department, :optional=>true

  def new
    new! do |format|
      format.html { render :partial=>"form"}
    end
  end

  def index
    if (request.xhr?)
      list
    else
      @credentials = current_account.credentials.by_department_and_type
      @show_title = true
      render 'index', :layout=>'left_sidebar'
    end

  end

  def quick_add
    render :partial=>"quick_add", :locals=>{:credential_type, params["credential_type"] || "Credential"}
  end

  def create
    type_name = "Credentials::#{params["type"]}"
    credential =type_name.classify.constantize.create!(params["credential"])
    credential["type_name"] = credential.type
    render :json=>credential
  end

  def list
    @department = current_account.departments.find(params[:department_id])
    raise "department_id required" unless @department
    credential_type = params[:credential_type]
    @credentials = (credential_type ?
            @department.credentials.by_type(credential_type) :
            @department.credentials).all.group_by{|cred|cred.type}
    render :partial=>"list"
  end

  def show
    id = params[:id]
    @credential = Credential.find(id)
    @compliance = EmployeeRequirementComplianceStatusCubicle.query do
      select :employee_id, :employee_name, :requirement_status, :all_measures
      by :mandatory
      where :requirement_id=>BSON::ObjectID(id)
      order_by :compliant, :employee_name
    end
    puts @compliance.inspect
    if request.xhr?
      render :partial=>"show"
    else
      index
    end
  end

  def update
    update! do |format|
      format.all {head :ok}
    end
  end

  def select
    @credentials = current_account.credentials.by_department_and_type
    render :partial=>"tree"
  end

end
