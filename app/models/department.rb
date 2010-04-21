class Department < ActiveRecord::Base
  include AccountModel

  belongs_to :department_head, :class_name=>'OrganizationalRole', :foreign_key=>'department_head_id'

  has_many :roles, :class_name=>'OrganizationalRole'
  
end
