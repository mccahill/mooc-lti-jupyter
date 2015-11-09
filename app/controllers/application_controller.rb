class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "base"
  
  before_filter :authorize

  private
  def authorize
    # TODO: Need to add check for students and OIT here
    if ENV['RAILS_ENV'] == 'development'
      # duid = '0198623'
      duid = '0489988'
      netid = 'liz'
    else
      duid = request.env['Shib-Duke-Unique-Id']
      netid = request.env['eppn'].split("@").first
    end
 
    
    session[:user_id] = duid    
    if Admin.find_by_netid( netid )
      session[:is_admin] = true
    else
      session[:is_admin] = false
    end
  end    
	def onlyAdmin
    unless( session[:is_admin])
			flash[:error] = "You do not have access to that function"
      logger.warn "User #{session[:user_id]} tried to access an Admin-Only Controller: #{params[:controller]}"
      redirect_to "/"
    end
	end
  
end
