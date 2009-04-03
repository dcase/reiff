# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  # before_filter :correct_safari_and_ie_accept_headers
  after_filter :discard_flash_on_ajax
  
  # Do not render template for AJAX calls
  layout proc{ |c| c.request.xhr? || c.request.format.js? ? false : "application" }
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3b9e9dd711cecfbc49c6f83032522029'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def bad_url_redirect
    flash[:error] = 'That URL does not exist.'
    redirect_to root_url
  end
  
  private
  
  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort!{ |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end
  
  def load_sections
    @site_sections = SiteSection.find(:all, :order => :position)
  end
  
  def authorized?(action = action_name, resource = nil)
    if params[:admin]
      logged_in? and params[:admin] != "false"
    else
      logged_in?
    end
  end
  
  def permission
    unless authorized?
      flash[:notice] = "You don't look like an admin to me"
      session[:back_url] = request.referer || root_path
      redirect_to session[:back_url]
    end
  end
  
  def discard_flash_on_ajax
    flash.discard if request.xhr? || request.format.js?
  end
end
