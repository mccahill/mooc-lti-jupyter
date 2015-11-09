class HomeController < ApplicationController
  layout "home"
  def index
  end
  def logout
     reset_session
     return_to_me = "?returnto=" + url_for(:controller=>'home')
     redirect_to "/Shibboleth.sso/Logout?return=https://shib.oit.duke.edu/cgi-bin/logout.pl" +
       CGI.escape(return_to_me)
   end
  
end
