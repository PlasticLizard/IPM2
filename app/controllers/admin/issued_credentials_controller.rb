class Admin::IssuedCredentialsController < InheritedResources::Base
  include AccountResourceController

  belongs_to :employee

  def edit
    edit! do |format|
      format.all { render :partial=>"edit_credential" }
    end
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
      format.json {render :json=>{:ok=>true}.to_json}
      format.any { head :ok}
    end
  end

  def select
    @credential = Credential.find(params[:credential_id])
    render :partial=>"select_credential"
  end

  def show
    @issued_credentials = parent.issued_credentials
    show! do |format|
      format.all {render :partial=>"list"}
    end

  end

  def issue
    credential = Credential.find(params[:credential_id])

    return head(:not_found) unless credential

    issue_date = params[:issue_date].blank? ? nil : Time.parse(params[:issue_date])
    expiration_date = params[:expiration_date].blank? ? nil : Time.parse(params[:expiration_date])

    parent.issue_credential(credential,:issue_date=>issue_date,:expiration_date=>expiration_date)
    head :ok
  end

  def revoke
    id = params[:issued_credential_id]
    parent.remove_credential(id)
    head :ok
  end

end
