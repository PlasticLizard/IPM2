class Department < ActiveRecord::Base
  include AccountModel

  acts_as_list :scope=>:account

  validates_presence_of :name
  validates_uniqueness_of :name, :scope=>:account_id
  
  belongs_to :department_head, :class_name=>'OrganizationalRole', :foreign_key=>'department_head_id'

  has_many :roles, :class_name=>'OrganizationalRole' 

  def before_save
    unless roles.size > 0
      self.department_head = roles.build :name=>"#{name} Director"
    end
  end

end
