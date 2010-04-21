class OrganizationalRole < ActiveRecord::Base
  include AccountModel
  acts_as_tree
  belongs_to :department

  def before_save
    self.department_id = parent.department_id unless ancestry.blank?
  end

end
