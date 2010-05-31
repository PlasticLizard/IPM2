class Admin::CredentialsController  < InheritedResources::Base
  include AccountResourceController
  def quick_add
    render :partial=>"quick_add", :locals=>{:credential_type, params["credential_type"] || "Credential"}
  end

  def create
    type_name = "Credentials::#{params["type"]}"
    credential =type_name.classify.constantize.create(params["credential"])
    render :json=>credential
  end
end
