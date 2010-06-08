class Admin::EmployeesController < InheritedResources::Base
  include AccountResourceController

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

  def select_credential
    render :partial=>"select_credential"
  end

  def issue_credential
    credential = Credential.find(params[:credential_id])

    return head(:not_found) unless credential
    
    issue_date = params[:issue_date].blank? ? nil : Time.parse(params[:issue_date])
    expiration_date = params[:expiration_date].blank? ? nil : Time.parse(params[:expiration_date])
    
    resource.issue_credential(credential,:issue_date=>issue_date,:expiration_date=>expiration_date)
    head :ok
  end

  def remove_credential
    id = params[:issued_credential_id]
    resource.remove_credential(id)
    head :ok
  end

end
