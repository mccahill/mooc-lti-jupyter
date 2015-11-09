class LtiUserSessionsController < ApplicationController
  layout 'admin_base'
  before_filter :onlyAdmin
  
  active_scaffold :"lti_user_session" do |conf|
    conf.label = 'LTI user sessions'
    conf.actions = [:list, :search, :show]
    active_scaffold_config.search.live = true   #submit search terms as we type for more feedback
    conf.list.sorting = { :id => :desc}
    conf.columns = [ :id, :userEmail, :username,  :userId, :destination, :action, :notes, :updated_at, :created_at ]   
  end
end
