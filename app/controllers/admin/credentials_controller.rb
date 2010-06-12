class Admin::CredentialsController  < InheritedResources::Base
  include AccountResourceController

  def index
    #loading of the collection is not needed, as we are dynamically loading by category (Credential Type)
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
    @credentials = (type = params["type"]) ?
            current_account.credentials.by_type(type) : current_account.credentials
    @credential_type = type
    render :partial=>"list"
  end

  def show
    show! do |format|
      format.html {render :partial=>"show"}  
    end
  end

  def update
    update! do |format|
      format.all {head :ok}
    end
  end
    
end
