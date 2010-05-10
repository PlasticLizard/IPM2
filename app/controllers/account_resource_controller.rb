class AccountResourceController < InheritedResources::Base
  protected

  def begin_of_association_chain
    current_account
  end

  def current_account
    Account.current
  end

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.all)
  end
end