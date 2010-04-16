class Account < ActiveRecord::Base
  has_many :people, :dependent=>:destroy
  has_many :organizational_units, :dependent=>:destroy

  cattr_accessor :current
  def self.set_current_account(account=nil)
    @@current = account
  end
  def self.clear_current_account()
    @@current = nil
  end


end