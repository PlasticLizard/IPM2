class OrganizationalRole < ActiveRecord::Base
  include AccountModel

  acts_as_tree

  belongs_to :department
  validates_presence_of :name

  enum_attr :position_type, %w(^exclusive team rotation) do
    label :exclusive=>"This role is assigned to a single individual"
    label :rotation=>"This role is divided into shifts scheduled via rotation"
    label :team=>"This role is shared by a team of peers"
  end

  def before_save
    self.department_id = parent.department_id unless ancestry.blank?
  end

end
