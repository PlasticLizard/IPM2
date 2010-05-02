class Account < ActiveRecord::Base
#  has_many :people, :dependent=>:destroy
#  has_many :users#, :conditions=>{:type=>"User"} <--May not be required?
#  has_many :employees
  has_many :companies, :dependent=>:destroy

  has_many :roles, :class_name=>'OrganizationalRole', :dependent=>:destroy
  has_many :departments, :dependent=>:destroy, :order=>'position' do
    def reorder(ordered_department_ids)
      all.each do |dep|
        dep.position = ordered_department_ids.index(dep.id.to_s) + 1
        dep.save
      end
    end
  end

  def organizational_structure
    [:company, :region, :base, :transport_unit]
  end

  cattr_accessor :current
  def self.set_current_account(account=nil)
    @@current = account
  end
  def self.clear_current_account()
    @@current = nil
  end

end