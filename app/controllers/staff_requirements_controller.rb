class StaffRequirementsController < ApplicationController
  include AccountResourceController

  def index
    @show_title = true
    @departments = current_account.roles.by_department
    @status = EmployeeRequirementStatusCubicle.query do
      select :compliance_status, :all_measures
      by     :company_id, :region_id
      where  :account_id => Account.current.id
    end
  end

  def show
    parent_type = params[:parent_type].to_sym
    parent_id =   params[:id]
    ou_type = Account.current.organizational_structure.child_of(parent_type, :as=>:symbol)
    puts "#{ou_type}_id".to_sym.inspect + ", " + "#{parent_type}_id".to_sym.inspect + ", " + parent_id
    children = EmployeeRequirementStatusCubicle.query do
      select :compliance_status, :all_measures
      by     "#{ou_type}_id".to_sym
      where  "#{parent_type}_id".to_sym => BSON::ObjectID(parent_id), :account_id=>Account.current.id
    end
    puts "Children:#{children.inspect}"
    render :partial=>"compliance_status_group", :locals=>{:collection=>children, :parent_type=>parent_type,:parent_id=>parent_id}
  end


#  def collection
#    query = current_account.employees
#    filter = {}
#    filter[:full_name]=/#{params[:q]}/i unless params[:q].blank?
#    filter[:department_id] = params[:departments] unless params[:departments].blank?
#    filter[:organizational_role_id] = params[:roles] unless params[:roles].blank?
#    filter[:organizational_unit_id] = params[:organizational_units] unless params[:organizational_units].blank?
#    query = query.all(filter) unless filter.blank?
#
#    @employees ||= query.paginate :page=>params[:page], :per_page=>(params[:per_page] || per_page)
#  end
end
