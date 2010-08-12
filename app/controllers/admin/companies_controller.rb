class Admin::CompaniesController  < Admin::OrganizationalUnitsController

  def collection
    @companies ||= current_account.companies
  end  
  


end
