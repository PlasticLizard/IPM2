# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_user!

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "no_nav"
    else
      "left_sidebar"
    end
  end

  def authenticate_user!
    super
    Account.set_current_account(current_user.account)
  end

end
