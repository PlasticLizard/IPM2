class AccountModel < ActiveRecord::Base
  validates_presence_of :account_id
  self.abstract_class = true

  def before_validation
    self.account = Account.current
  end
end