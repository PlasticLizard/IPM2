class Admin::EmployeesController < InheritedResources::Base
  include AccountResourceController

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

  
end
