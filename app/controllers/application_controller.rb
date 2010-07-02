# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authorize_account

  layout "left_sidebar"
  
  def authorize_account
    if (Rails.env == "development" && params["_account"])
      Account.set_current_account(Account.find(params["_account"].to_i))
    else
      Account.set_current_account(Account.first)
    end
  end
  # Scrub sensitive parameters from your log
   filter_parameter_logging :password
end
