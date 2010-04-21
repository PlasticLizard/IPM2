module AccountModel
  def self.included(model)
    model.validates_presence_of :account_id
    model.belongs_to :account
  end

  def before_validation
    self.account = Account.current
  end
end