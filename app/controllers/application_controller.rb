# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def check_errors(good, item)
    if good
      flash[:notice] = "Pomyślnie wykonano operację"
      return true
    elsif !good
      flash[:error] = "<ul>"
      item.errors.each_full do |msg|
        flash[:error] += "<li>"+ msg +"</li>"
      end
      flash[:error] += "</ul>"
      return false
    elsif good.nil?
      flash[:error] = "Błędny parametr"
      return false
    end
  end
end
