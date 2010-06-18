class Admin::CredentialsController  < InheritedResources::Base
  include AccountResourceController

  belongs_to :department, :optional=>true

  def index
    @credentials = current_account.credentials.by_department_and_type
    @show_title = true
    render :layout=>'left_sidebar'
  end

  def quick_add
    render :partial=>"quick_add", :locals=>{:credential_type, params["credential_type"] || "Credential"}
  end
  
  def create
    type_name = "Credentials::#{params["type"]}"
    credential =type_name.classify.constantize.create!(params["credential"])
    render :json=>credential
  end

  def list    
    @credentials = current_account.credentials.by_department_and_type
    render request.xhr? ? {:partial=>"list"} : :list
  end

  def show
    show! do |format|
      format.html { render request.xhr? ? {:partial=>"show"} :  :show}  
    end
  end

  def update
    update! do |format|
      format.all {head :ok}
    end
  end
    
end
