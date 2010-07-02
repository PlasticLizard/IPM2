class Admin::CompaniesController  < Admin::OrganizationalUnitsController

  def collection
    @companies ||= current_account.companies
  end  
  
  def index
    @show_title = true
    index! do |format|
      format.html { render :layout=>'left_sidebar'}
    end
  end

end
