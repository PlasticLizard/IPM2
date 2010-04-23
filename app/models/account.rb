class Account < ActiveRecord::Base
#  has_many :people, :dependent=>:destroy
#  has_many :users#, :conditions=>{:type=>"User"} <--May not be required?
#  has_many :employees
  has_many :companies, :dependent=>:destroy
  
  has_many :roles, :class_name=>'OrganizationalRole', :dependent=>:destroy
  has_many :departments, :dependent=>:destroy

  def organizational_structure
    [:region, :station, :transport_unit]
  end

  cattr_accessor :current
  def self.set_current_account(account=nil)
    @@current = account
  end
  def self.clear_current_account()
    @@current = nil
  end

end