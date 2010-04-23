class OrganizationalRole < ActiveRecord::Base
  include AccountModel
  acts_as_tree
  belongs_to :department

  enum_attr :position_type, %w(^exclusive team rotation)
  #label :exclusive=>"This role is assigned to a single individual"
  #label :team=>"This role is shared by two or more peers during regular business hours"
  #label :rotation=>"This role is divided into shifts and staffed based on a rotational schedule"

  def before_save
    self.department_id = parent.department_id unless ancestry.blank?
  end

end
