class AccountResourceController < InheritedResources::Base
  protected

  def begin_of_association_chain
    current_account
  end

  def current_account
    Account.current
  end  
end